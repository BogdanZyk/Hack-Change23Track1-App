package main

import (
	"fmt"
	"os"
	"os/signal"
	"path/filepath"
	"syscall"

	"gitlab.com/tatsiyev/audio-stream/models"
	http_api "gitlab.com/tatsiyev/audio-stream/protocol/http"
	webrtc_api "gitlab.com/tatsiyev/audio-stream/protocol/webrtc"
	"gitlab.com/tatsiyev/audio-stream/secret"
	"gitlab.com/tatsiyev/audio-stream/server"
	"gitlab.com/tatsiyev/audio-stream/storage"
)

func main() {

	exPath, _ := os.Executable()
	path := filepath.Dir(exPath)
	os.RemoveAll(fmt.Sprintf("%s/public/uploads/rooms", path))

	conf := server.DefaultConfig()

	var err error = nil
	var errChan chan error = make(chan error)

	s := &models.Server{
		CandidateSocket: make(map[string]*models.CandidateSocketData),
	}

	s.Database, err = server.InitDatabase()
	if err != nil {
		fmt.Println(err)
		return
	}

	httpServer, err := http_api.NewHTTPServer(conf.Port, s)
	if err != nil {
		fmt.Println(err)
		return
	}

	s.TokenGenegator = secret.NewTokenManager(conf.Secret.Sign)
	s.HashGenegator = secret.NewHashManager(conf.Secret.Salt)

	s.DataStorage = storage.NewStorage(s)
	s.WebrtcServer = webrtc_api.NewWebRTCServer(s)

	go func() {
		errChan <- httpServer.HttpServer.ListenAndServe()
	}()

	fmt.Println("application started")

	sigChan := make(chan os.Signal, 1)
	signal.Notify(sigChan,
		syscall.SIGHUP,
		syscall.SIGINT,
		syscall.SIGTERM,
		syscall.SIGQUIT)

	select {
	case e := <-errChan:
		fmt.Println("exit app with error", e)
	case <-sigChan:
		fmt.Println("exit app os signal")
	}
}
