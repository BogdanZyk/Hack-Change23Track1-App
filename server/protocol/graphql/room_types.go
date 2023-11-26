package graphql

import (
	"fmt"

	"github.com/graphql-go/graphql"
	"gitlab.com/tatsiyev/audio-stream/models"
	"gitlab.com/tatsiyev/audio-stream/storage"
)

var RoomTypeEnum = graphql.NewEnum(graphql.EnumConfig{
	Name: "RoomType",
	Values: graphql.EnumValueConfigMap{
		"NO_TYPE":  &graphql.EnumValueConfig{Value: "NO_TYPE"},
		"SINGLE":   &graphql.EnumValueConfig{Value: "SINGLE"},
		"PLAYLIST": &graphql.EnumValueConfig{Value: "PLAYLIST"},
	}})

var FieldRoomType = graphql.NewObject(graphql.ObjectConfig{
	Name: "Room",
	Fields: graphql.Fields{
		"Id":       &graphql.Field{Type: graphql.String},
		"Name":     &graphql.Field{Type: graphql.String},
		"Key":      &graphql.Field{Type: graphql.String},
		"Image":    &graphql.Field{Type: graphql.String},
		"Private":  &graphql.Field{Type: graphql.Boolean},
		"Type":     &graphql.Field{Type: graphql.String},
		"Likes":    &graphql.Field{Type: graphql.Int},
		"File":     &graphql.Field{Type: FieldPlayFileType},
		"Members":  &graphql.Field{Type: graphql.NewList(FieldUserType)},
		"Owner":    &graphql.Field{Type: FieldUserType},
		"Playlist": &graphql.Field{Type: &graphql.List{OfType: FieldAudioType}},
	},
})

func (g *GraphqlApi) ListRooms() *graphql.Field {
	return &graphql.Field{
		Type: &graphql.List{OfType: FieldRoomType},
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {
			rooms := g.Server.DataStorage.GetRooms()
			return rooms, nil
		},
	}
}
func (g *GraphqlApi) GetRoomByKey() *graphql.Field {
	return &graphql.Field{
		Type: FieldRoomType,
		Args: graphql.FieldConfigArgument{
			"Key": &graphql.ArgumentConfig{
				Type: graphql.NewNonNull(graphql.String),
			},
		},
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {
			key := p.Args["Key"]
			if key == nil {
				return nil, fmt.Errorf("key is empty")
			}
			room, err := g.Server.DataStorage.GetRoomByKey(key.(string))
			return room, err
		},
	}
}

func (g *GraphqlApi) CreateRoom() *graphql.Field {
	return &graphql.Field{
		Type: FieldRoomType,
		Args: graphql.FieldConfigArgument{
			"Name": &graphql.ArgumentConfig{
				Type: graphql.NewNonNull(graphql.String),
			},
			"Image": &graphql.ArgumentConfig{
				Type: graphql.String,
			},
			"Private": &graphql.ArgumentConfig{
				Type: graphql.Boolean,
			},
			"Type": &graphql.ArgumentConfig{
				Type: RoomTypeEnum,
			},
		},
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {
			user, ok := p.Context.Value(ContextUser).(*models.User)
			if !ok || user == nil {
				return nil, fmt.Errorf("need authorization")
			}

			newRoom := &models.Room{}

			avatar := p.Args["Image"]
			if avatar != nil {
				path, err := storage.SaveBase64File(avatar.(string), "rooms")
				if err != nil {
					return nil, err
				}
				newRoom.Image = path
			}
			name := p.Args["Name"]
			if name != nil {
				newRoom.Name = name.(string)
			}
			private := p.Args["Private"]
			if private != nil {
				newRoom.Private = private.(bool)
			}
			roomType := p.Args["Type"]
			if roomType != nil {
				roomTypeString := roomType.(string)
				newRoom.Type = models.RoomType(roomTypeString)
			}

			room := g.Server.DataStorage.CreateRoom(newRoom)
			room.Owner = user

			return room, nil
		},
	}
}

func (g *GraphqlApi) LoadAudio() *graphql.Field {
	return &graphql.Field{
		Type: FieldRoomType,
		Args: graphql.FieldConfigArgument{
			"RoomId": &graphql.ArgumentConfig{
				Type: graphql.NewNonNull(graphql.String),
			},
			"AudioId": &graphql.ArgumentConfig{
				Type: graphql.NewNonNull(graphql.String),
			},
		},
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {
			RoomId := p.Args["RoomId"].(string)
			AudioId := p.Args["AudioId"].(string)

			user, ok := p.Context.Value(ContextUser).(*models.User)
			if !ok || user == nil {
				return nil, fmt.Errorf("need authorization")
			}

			room, err := g.Server.DataStorage.GetRoom(RoomId)
			if err != nil {
				return nil, err
			}
			if user.Id != room.Owner.Id {
				return nil, fmt.Errorf("you not owner")
			}

			room, err = g.Server.DataStorage.OpenFile(RoomId, AudioId)
			return room, err
		},
	}
}

func (g *GraphqlApi) RoomAction() *graphql.Field {
	return &graphql.Field{
		Type: FieldRoomType,
		Args: graphql.FieldConfigArgument{
			"RoomId": &graphql.ArgumentConfig{
				Type: graphql.NewNonNull(graphql.String),
			},
			"Action": &graphql.ArgumentConfig{
				Type: graphql.NewNonNull(graphql.String),
			},
			"Arg": &graphql.ArgumentConfig{
				Type: graphql.NewNonNull(graphql.String),
			},
		},
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {
			RoomId := p.Args["RoomId"].(string)
			Action := p.Args["Action"].(string)
			Arg := p.Args["Arg"].(string)

			user, ok := p.Context.Value(ContextUser).(*models.User)
			if !ok || user == nil {
				return nil, fmt.Errorf("need authorization")
			}

			room, err := g.Server.DataStorage.GetRoom(RoomId)
			if err != nil {
				return nil, err
			}
			if user.Id != room.Owner.Id {
				return nil, fmt.Errorf("you not owner")
			}

			room, err = g.Server.DataStorage.Action(RoomId, Action, Arg)

			return room, err
		},
	}
}

func (g *GraphqlApi) UpdateRoom() *graphql.Field {
	return &graphql.Field{
		Type: FieldRoomType,
		Args: graphql.FieldConfigArgument{
			"RoomId": &graphql.ArgumentConfig{
				Type: graphql.NewNonNull(graphql.String),
			},
			"Name": &graphql.ArgumentConfig{
				Type: graphql.String,
			},
			"Image": &graphql.ArgumentConfig{
				Type: graphql.String,
			},
			"Private": &graphql.ArgumentConfig{
				Type: graphql.Boolean,
			},
			"Type": &graphql.ArgumentConfig{
				Type: RoomTypeEnum,
			},
		},
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {
			RoomId := p.Args["RoomId"].(string)

			currentUser, ok := p.Context.Value(ContextUser).(*models.User)
			if !ok || currentUser == nil {
				return nil, fmt.Errorf("need authorization")
			}

			room, err := g.Server.DataStorage.GetRoom(RoomId)
			if err != nil {
				return nil, err
			}
			if currentUser.Id != room.Owner.Id {
				return nil, fmt.Errorf("you not owner")
			}

			newRoom := &models.Room{}

			avatar := p.Args["Image"]
			if avatar != nil {
				path, err := storage.SaveBase64File(avatar.(string), "rooms")
				if err != nil {
					return nil, err
				}
				newRoom.Image = path
			}
			name := p.Args["Name"]
			if name != nil {
				newRoom.Name = name.(string)
			}
			private := p.Args["Private"]
			if private != nil {
				newRoom.Private = private.(bool)
			}
			roomType := p.Args["Type"]
			if roomType != nil {
				roomTypeString := roomType.(string)
				newRoom.Type = models.RoomType(roomTypeString)
			}

			room, err = g.Server.DataStorage.UpdateRoom(RoomId, newRoom)
			return room, err
		},
	}
}

func (g *GraphqlApi) DeleteRoom() *graphql.Field {
	return &graphql.Field{
		Type: FieldRoomType,
		Args: graphql.FieldConfigArgument{
			"RoomId": &graphql.ArgumentConfig{
				Type: graphql.NewNonNull(graphql.String),
			},
		},
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {
			RoomId := p.Args["RoomId"].(string)

			user, ok := p.Context.Value(ContextUser).(*models.User)
			if !ok || user == nil {
				return nil, fmt.Errorf("need authorization")
			}

			room, err := g.Server.DataStorage.GetRoom(RoomId)
			if err != nil {
				return nil, err
			}
			if user.Id != room.Owner.Id {
				return nil, fmt.Errorf("you not owner")
			}

			err = g.Server.DataStorage.DeleteRoom(RoomId)
			return nil, err
		},
	}
}

func (g *GraphqlApi) LikeRoom() *graphql.Field {
	return &graphql.Field{
		Type: FieldRoomType,
		Args: graphql.FieldConfigArgument{
			"RoomId": &graphql.ArgumentConfig{
				Type: graphql.NewNonNull(graphql.String),
			},
		},
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {
			RoomId := p.Args["RoomId"].(string)
			room, err := g.Server.DataStorage.GetRoom(RoomId)
			room.Likes++
			return room, err
		},
	}
}
