package http

import (
	"context"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"strings"

	"github.com/graphql-go/graphql"
	"github.com/graphql-go/graphql/gqlerrors"
	"gitlab.com/tatsiyev/audio-stream/models"
	api_graphql "gitlab.com/tatsiyev/audio-stream/protocol/graphql"
)

type GraphqlQuery struct {
	Query         string                 `json:"query"`
	Variables     map[string]interface{} `json:"variables"`
	OperationName string                 `json:"operationName"`
}

func (h *HTTP) Graphql(w http.ResponseWriter, r *http.Request) {
	var result *graphql.Result = &graphql.Result{}

	body, err := io.ReadAll(r.Body)

	if err != nil {
		result.Errors = make([]gqlerrors.FormattedError, 0)
		result.Errors = append(result.Errors, gqlerrors.FormattedError{Message: err.Error()})
	} else {
		var query *GraphqlQuery
		err = json.Unmarshal(body, &query)

		if err != nil {
			result.Errors = make([]gqlerrors.FormattedError, 0)
			result.Errors = append(result.Errors, gqlerrors.FormattedError{Message: err.Error()})
		} else {
			authorization := r.Header.Get("Authorization")
			token := strings.Replace(authorization, "Bearer ", "", 1)
			user, err := h.Server.DataStorage.CurrnetUser(token)

			ctx := context.Background()

			if err == nil {
				ctx = context.WithValue(ctx, api_graphql.ContextUser, user)
			}

			result = graphql.Do(graphql.Params{
				RequestString:  query.Query,
				VariableValues: query.Variables,
				OperationName:  query.OperationName,
				Schema:         h.Schema,
				Context:        ctx,
			})
		}
	}
	w.Header().Add("Access-Control-Allow-Origin", "*")
	w.Header().Add("Access-Control-Allow-Methods", "*")
	w.Header().Add("Access-Control-Allow-Headers", "*")
	w.Header().Add("Content-Type", "application/json")
	json.NewEncoder(w).Encode(result)
}

func NewGraphqlSchema(s *models.Server) (graphql.Schema, error) {

	graphqlApi, err := api_graphql.NewGraphqlApi(s)

	if err != nil {
		return graphql.Schema{}, fmt.Errorf("failed to create new schema, error: %v", err)
	}

	return graphqlApi.Schema, nil
}
