package graphql

import (
	"github.com/graphql-go/graphql"
)

var FieldStickerPack = graphql.NewObject(graphql.ObjectConfig{
	Name: "StickerPack",
	Fields: graphql.Fields{
		"Name":     &graphql.Field{Type: graphql.String},
		"Stickers": &graphql.Field{Type: &graphql.List{OfType: graphql.String}},
	},
})

func (g *GraphqlApi) AllStickers() *graphql.Field {
	return &graphql.Field{
		Type: &graphql.List{OfType: FieldStickerPack},
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {
			stickers := g.Server.DataStorage.GetAllStickers()
			return stickers, nil
		},
	}
}
