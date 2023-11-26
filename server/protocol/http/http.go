package http

import (
	"fmt"
	"net/http"
	"os"

	"gitlab.com/tatsiyev/audio-stream/models"

	"github.com/gorilla/mux"
	"github.com/graphql-go/graphql"
)

type HTTP struct {
	Server *models.Server
	Schema graphql.Schema

	Router     *mux.Router
	HttpServer *http.Server
}

func NewHTTPServer(port string, s *models.Server) (*HTTP, error) {
	httpServer := &HTTP{
		Server: s,
	}

	httpServer.Router = mux.NewRouter()
	httpServer.HttpServer = &http.Server{
		Addr:    fmt.Sprintf("0.0.0.0:%s", port),
		Handler: httpServer.Router,
	}

	graphqlSchema, err := NewGraphqlSchema(s)
	if err != nil {
		return nil, err
	}
	httpServer.Schema = graphqlSchema

	httpServer.Router.HandleFunc("/uploads/{name:.+}", handleImages)

	api := httpServer.Router.PathPrefix("/api").Subrouter()
	api.HandleFunc("", httpServer.Graphql)

	httpServer.Router.PathPrefix("/").Handler(http.StripPrefix("/", http.FileServer(http.Dir("./static/"))))

	return httpServer, nil
}

func handleImages(w http.ResponseWriter, r *http.Request) {
	name, ok := mux.Vars(r)["name"]
	if !ok {
		w.WriteHeader(404)
		return
	}

	buf, err := os.ReadFile(fmt.Sprintf("./public/uploads/%s", name))

	if err != nil {
		w.WriteHeader(404)
		return
	}

	w.Header().Set("Content-Type", "image/png")
	w.Write(buf)
}
