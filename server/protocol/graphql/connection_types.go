package graphql

import (
	"github.com/graphql-go/graphql"
	"gitlab.com/tatsiyev/audio-stream/models"
)

var FieldSDPType = graphql.NewObject(graphql.ObjectConfig{
	Name: "ClientSDP",
	Fields: graphql.Fields{
		"Type": &graphql.Field{Type: graphql.NewNonNull(graphql.String)},
		"Sdp":  &graphql.Field{Type: graphql.NewNonNull(graphql.String)},
	},
})

var FieldSDPInputType = graphql.NewInputObject(graphql.InputObjectConfig{
	Name: "ServerSDP",
	Fields: graphql.InputObjectConfigFieldMap{
		"Type": &graphql.InputObjectFieldConfig{Type: graphql.String},
		"Sdp":  &graphql.InputObjectFieldConfig{Type: graphql.String},
	},
})

func (g *GraphqlApi) InitConnection() *graphql.Field {
	return &graphql.Field{
		Type: FieldSDPType,
		Args: graphql.FieldConfigArgument{
			"RoomId": &graphql.ArgumentConfig{
				Type: graphql.NewNonNull(graphql.String),
			},
			"SDP": &graphql.ArgumentConfig{
				Type: graphql.NewNonNull(FieldSDPInputType),
			},
		},
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {
			roomId := p.Args["RoomId"].(string)
			clientSdp := p.Args["SDP"].(map[string]interface{})

			ctxuser := p.Context.Value(ContextUser)
			currentUser, _ := ctxuser.(*models.User)

			serverSdp, err := g.Server.WebrtcServer.NewClient(roomId, &models.SDP{Type: clientSdp["Type"].(string), SDP: clientSdp["Sdp"].(string)}, currentUser)
			return serverSdp, err
		},
	}
}
