package graphql

import (
	"fmt"

	"github.com/graphql-go/graphql"
	"gitlab.com/tatsiyev/audio-stream/models"
)

type GraphqlApi struct {
	Server *models.Server
	Schema graphql.Schema
}

func NewGraphqlApi(s *models.Server) (*GraphqlApi, error) {
	api := &GraphqlApi{
		Server: s,
	}

	config := graphql.SchemaConfig{
		Directives: []*graphql.Directive{graphql.IncludeDirective, graphql.SkipDirective},
		Query:      graphql.NewObject(graphql.ObjectConfig{Name: "RootQueryType", Fields: api.Queries()}),
		Mutation:   graphql.NewObject(graphql.ObjectConfig{Name: "RootMutationType", Fields: api.Mutations()}),
		Types:      []graphql.Type{},
	}

	schema, err := graphql.NewSchema(config)

	if err != nil {
		return nil, fmt.Errorf("failed to create new schema, error: %v", err)
	}

	api.Schema = schema

	return api, nil
}

func (g *GraphqlApi) Queries() graphql.Fields {
	return graphql.Fields{
		"CurrentUser":  g.CurrentUser(),
		"ListRooms":    g.ListRooms(),
		"GetRoomByKey": g.GetRoomByKey(),
		"ListAudio":    g.ListAudio(),
		"SearchAudio":  g.SearchAudio(),
		"AllStickers":  g.AllStickers(),
	}
}
func (g *GraphqlApi) Mutations() graphql.Fields {
	return graphql.Fields{
		"SignUp":            g.SignUp(),
		"SignIn":            g.SignIn(),
		"UpdateCurrentUser": g.UpdateCurrentUser(),

		"InitConnection": g.InitConnection(),

		"CreateRoom": g.CreateRoom(),
		"UpdateRoom": g.UpdateRoom(),
		"DeleteRoom": g.DeleteRoom(),
		"LikeRoom":   g.LikeRoom(),
		"LoadAudio":  g.LoadAudio(),
		"RoomAction": g.RoomAction(),
	}
}
