package graphql

import (
	"fmt"

	"github.com/graphql-go/graphql"
	"gitlab.com/tatsiyev/audio-stream/models"
	"gitlab.com/tatsiyev/audio-stream/storage"
)

type contextType string

var (
	ContextUser contextType = "user"
)

var Token = graphql.NewObject(graphql.ObjectConfig{
	Name: "Token",
	Fields: graphql.Fields{
		"Token": &graphql.Field{Type: graphql.NewNonNull(graphql.String)},
	},
})

var FieldUserType = graphql.NewObject(graphql.ObjectConfig{
	Name: "User",
	Fields: graphql.Fields{
		"Id":     &graphql.Field{Type: graphql.NewNonNull(graphql.String)},
		"Email":  &graphql.Field{Type: graphql.NewNonNull(graphql.String)},
		"Login":  &graphql.Field{Type: graphql.NewNonNull(graphql.String)},
		"Avatar": &graphql.Field{Type: graphql.NewNonNull(graphql.String)},
	},
})

func (g *GraphqlApi) SignIn() *graphql.Field {
	return &graphql.Field{
		Type: Token,
		Args: graphql.FieldConfigArgument{
			"Email": &graphql.ArgumentConfig{
				Type: graphql.NewNonNull(graphql.String),
			},
			"Password": &graphql.ArgumentConfig{
				Type: graphql.NewNonNull(graphql.String),
			},
		},
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {
			email := p.Args["Email"].(string)
			password := p.Args["Password"].(string)

			token, err := g.Server.DataStorage.SignIn(email, password)

			return map[string]interface{}{"Token": token}, err
		},
	}
}
func (g *GraphqlApi) SignUp() *graphql.Field {
	return &graphql.Field{
		Type: Token,
		Args: graphql.FieldConfigArgument{
			"Email": &graphql.ArgumentConfig{
				Type: graphql.NewNonNull(graphql.String),
			},
			"Login": &graphql.ArgumentConfig{
				Type: graphql.NewNonNull(graphql.String),
			},
			"Password": &graphql.ArgumentConfig{
				Type: graphql.NewNonNull(graphql.String),
			},
		},
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {
			email := p.Args["Email"].(string)
			login := p.Args["Login"].(string)
			password := p.Args["Password"].(string)

			token, err := g.Server.DataStorage.SignUp(email, login, password)

			return map[string]interface{}{"Token": token}, err
		},
	}
}

func (g *GraphqlApi) CurrentUser() *graphql.Field {
	return &graphql.Field{
		Type: FieldUserType,
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {
			ctxuser := p.Context.Value(ContextUser)

			if ctxuser == nil {
				return nil, fmt.Errorf("user not found")
			}

			return ctxuser.(*models.User), nil
		},
	}
}

func (g *GraphqlApi) UpdateCurrentUser() *graphql.Field {
	return &graphql.Field{
		Type: FieldUserType,
		Args: graphql.FieldConfigArgument{
			"Login": &graphql.ArgumentConfig{
				Type: graphql.String,
			},
			"Avatar": &graphql.ArgumentConfig{
				Type: graphql.String,
			},
		},
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {
			ctxuser := p.Context.Value(ContextUser)

			if ctxuser == nil {
				return nil, fmt.Errorf("user not found")
			}
			currentUser := ctxuser.(*models.User)

			newUser := &models.User{}

			avatar := p.Args["Avatar"]
			if avatar != nil {
				path, err := storage.SaveBase64File(avatar.(string), "users")
				if err != nil {
					return nil, err
				}
				newUser.Avatar = path
			}
			login := p.Args["Login"]
			if login != nil {
				newUser.Login = login.(string)
			}

			user, err := g.Server.DataStorage.UserInterface.UpdateUser(currentUser.Id, newUser)

			return user, err
		},
	}
}
