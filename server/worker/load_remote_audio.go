package worker

import (
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"net/http"
	"os"
	"path/filepath"
	"sync"

	"github.com/pion/webrtc/v4"
	"gitlab.com/tatsiyev/audio-stream/models"
)

const RemoteDomain = "http://45.12.237.146"

func makeRemoteFileUrl(file *models.File) string {
	return fmt.Sprintf("%s/uploads/audio/%s", RemoteDomain, file.Path)
}
func makeFilePath(file *models.File) string {
	return fmt.Sprintf("./content/%s", file.Path)
}

func sendStatuses(statuses *models.NewPlaylistStatus, dc *webrtc.DataChannel) {
	ansver, err := json.Marshal(statuses)
	if err != nil {
		fmt.Println("error send struct", err)
		return
	}
	if dc == nil {
		fmt.Println(statuses)
		return
	}
	dc.SendText(string(ansver))
}
func updateStatuses(statuses *models.NewPlaylistStatus, id int, status string, dc *webrtc.DataChannel) {
	statuses.Statuses[id].Status = status
	sendStatuses(statuses, dc)
}

func LoadRemoteAudio(playlist models.NewPlaylist, dc *webrtc.DataChannel, server *models.Server) {
	wait := &sync.WaitGroup{}
	wait.Add(len(playlist.Files))

	statuses := &models.NewPlaylistStatus{
		Statuses: make([]models.FileStatus, 0),
	}

	for _, fileId := range playlist.Files {
		statuses.Statuses = append(statuses.Statuses, models.FileStatus{
			Id:     fileId,
			Status: "wait",
		})
	}

	for id := range playlist.Files {
		go func(capturedId int) {
			defer wait.Done()
			databasefile, err := server.DataStorage.GetFile(playlist.Files[capturedId])
			if err != nil {
				updateStatuses(statuses, capturedId, "error", dc)
				return
			}
			downloadUrl := makeRemoteFileUrl(databasefile)
			filePath := makeFilePath(databasefile)

			exPath, err := os.Executable()
			if err != nil {
				updateStatuses(statuses, capturedId, "error", dc)
				return
			}
			path := filepath.Dir(exPath)

			err = os.MkdirAll(fmt.Sprintf("%s/content/", path), 0755)
			if err != nil {
				updateStatuses(statuses, capturedId, "error", dc)
				return
			}

			if _, err := os.Stat(filePath); err == nil {
				updateStatuses(statuses, capturedId, "ok", dc)
				return
			}

			updateStatuses(statuses, capturedId, "download", dc)

			err = downloadFile(downloadUrl, filePath)
			if err != nil {
				updateStatuses(statuses, capturedId, "error", dc)
				return
			}
			updateStatuses(statuses, capturedId, "ok", dc)

		}(id)
	}

	wait.Wait()
}

func downloadFile(URL, fileName string) error {
	//Get the response bytes from the url
	response, err := http.Get(URL)
	if err != nil {
		return err
	}
	defer response.Body.Close()

	if response.StatusCode != 200 {
		return errors.New("received non 200 response code")
	}
	//Create a empty file
	file, err := os.Create(fileName)
	if err != nil {
		return err
	}
	defer file.Close()

	//Write the bytes to the fiel
	_, err = io.Copy(file, response.Body)
	if err != nil {
		return err
	}

	return nil
}
