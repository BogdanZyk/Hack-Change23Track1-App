package graphql

import (
	"github.com/graphql-go/graphql"
)

var FieldPlayFileType = graphql.NewObject(graphql.ObjectConfig{
	Name: "PlayFile",
	Fields: graphql.Fields{
		"File":            &graphql.Field{Type: FieldAudioType},
		"Pause":           &graphql.Field{Type: graphql.Boolean},
		"DurationSeconds": &graphql.Field{Type: graphql.String},
		"CurrentSeconds":  &graphql.Field{Type: graphql.String},
	},
})

var FieldAudioType = graphql.NewObject(graphql.ObjectConfig{
	Name: "Audio",
	Fields: graphql.Fields{
		"Id":    &graphql.Field{Type: graphql.String},
		"Name":  &graphql.Field{Type: graphql.String},
		"Cover": &graphql.Field{Type: graphql.String},
	},
})

func (g *GraphqlApi) ListAudio() *graphql.Field {
	return &graphql.Field{
		Type: &graphql.List{OfType: FieldAudioType},
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {
			files := g.Server.DataStorage.FileInterface.GetFiles()
			return files, nil
		},
	}
}
func (g *GraphqlApi) SearchAudio() *graphql.Field {
	return &graphql.Field{
		Type: &graphql.List{OfType: FieldAudioType},
		Args: graphql.FieldConfigArgument{
			"Query": &graphql.ArgumentConfig{
				Type: graphql.NewNonNull(graphql.String),
			},
		},
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {
			query := p.Args["Query"]
			if query == nil {
				query = ""
			}
			files := g.Server.DataStorage.FileInterface.SearchFiles(query.(string))
			return files, nil
		},
	}
}
