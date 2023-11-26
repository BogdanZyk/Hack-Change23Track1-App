package webrtc

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"os"
	"time"

	"github.com/google/uuid"
	"github.com/pion/webrtc/v4"
	"github.com/pion/webrtc/v4/pkg/media"
	"github.com/pion/webrtc/v4/pkg/media/oggreader"
	"gitlab.com/tatsiyev/audio-stream/models"
	"gitlab.com/tatsiyev/audio-stream/worker"
)

type StreamRoom struct {
	WebRTC *WebRTCServer
	Room   *models.Room
	id     string

	clients map[string]*StreamClient

	track *webrtc.TrackLocalStaticSample
}

type StreamInfo struct {
	Likes    int64   `json:"likes"`
	Status   string  `json:"status"`
	FileId   string  `json:"file_id"`
	Current  float64 `json:"current"`
	Duration float64 `json:"duration"`
	// Playlist []string `json:"playlist"`
}

func (r *StreamRoom) MakeStreamInfo() *StreamInfo {
	var status string
	if r.Room.File.Pause {
		status = "pause"
	} else {
		status = "play"
	}

	currentTime := float64(r.Room.File.Current) / float64(time.Second)
	currentFileDuration := float64(r.Room.File.Duration) / float64(time.Second)

	info := &StreamInfo{
		Likes:    r.Room.Likes,
		Status:   status,
		FileId:   r.Room.File.File.Id,
		Current:  currentTime,
		Duration: currentFileDuration,
		// Playlist: r.Room.Playlist,
	}

	return info
}

var oggPageDuration = 20 * time.Millisecond

func NewStreemRoom(webrtcServer *WebRTCServer, room *models.Room) *StreamRoom {
	streemRoom := &StreamRoom{
		clients: make(map[string]*StreamClient),
		WebRTC:  webrtcServer,
		Room:    room,
	}
	streemRoom.Room.File = &models.PlayFile{Pause: true}

	audioTrack, audioTrackErr := webrtc.NewTrackLocalStaticSample(webrtc.RTPCodecCapability{MimeType: webrtc.MimeTypeOpus}, "audio", "pion")
	if audioTrackErr != nil {
		fmt.Println("error create stream")
	}

	streemRoom.track = audioTrack
	streemRoom.Room.File.Context, streemRoom.Room.File.ContextCancel = context.WithCancel(context.Background())
	return streemRoom
}

func (r *StreamRoom) NewClient(clientSdp *models.SDP, currentUser *models.User) (*models.SDP, error) {
	key := models.RandSeq(8)
	if currentUser == nil {
		currentUser = &models.User{Id: uuid.NewString(), Login: "Anonymous User"}
	}
	client := &StreamClient{key: key, room: r, User: currentUser}
	r.clients[key] = client

	sdpServer := make(chan *models.SDP)
	defer close(sdpServer)

	go client.ClientWorker(clientSdp, sdpServer)

	select {
	case sdp := <-sdpServer:
		r.Room.Users[key] = currentUser
		return sdp, nil
	case <-time.After(60 * time.Second):
		return nil, fmt.Errorf("error create sever SDP")
	}
}

func localFile(file *models.File) string {
	return fmt.Sprintf("./content/%s", file.Path)
}

func (r *StreamRoom) LoadFile(fileId string) error {
	firstFile := r.Room.File.File == nil

	prevFilePause := r.Room.File.Pause
	r.Room.File.Pause = true

	file, err := r.WebRTC.Server.DataStorage.GetFile(fileId)
	if err != nil {
		return err
	}

	audioFile, openErr := os.Open(localFile(file))
	if openErr != nil {
		return r.OnFileEnd()
	}

	ogg, _, openErr := oggreader.NewWith(audioFile)
	if openErr != nil {
		return openErr
	}

	r.Room.File.Reader = ogg
	r.Room.File.File = file

	duration, err := FileDuration(localFile(file))
	if err != nil {
		return err
	}
	r.Room.File.Duration = duration
	r.Room.File.DurationSeconds = float64(r.Room.File.Duration) / float64(time.Second)
	r.Room.File.Current = 0
	r.Room.File.CurrentSeconds = 0

	if firstFile {
		r.Room.File.ContextCancel()
	}

	r.Room.File.Pause = prevFilePause

	fmt.Println("load file")

	r.SendRoomInfoAllClients()
	return nil
}

func (r *StreamRoom) MoveFile(duration time.Duration) error {
	prevFilePause := r.Room.File.Pause
	r.Room.File.Pause = true
	r.Room.File.Current = 0
	audioFile, openErr := os.Open(localFile(r.Room.File.File))
	if openErr != nil {
		return openErr
	}

	ogg, _, openErr := oggreader.NewWith(audioFile)
	if openErr != nil {
		return openErr
	}

	r.Room.File.Reader = ogg

	var oggError error
	var pageHeader *oggreader.OggPageHeader
	for i := time.Duration(0); i < duration-oggPageDuration; i += oggPageDuration {
		_, pageHeader, oggError = r.Room.File.Reader.ParseNextPage()
		if oggError != nil {
			r.Room.File.Pause = true
		}
		r.Room.File.Current += oggPageDuration
		r.Room.File.LastGranule = pageHeader.GranulePosition
	}
	r.Room.File.CurrentSeconds = float64(r.Room.File.Current) / float64(time.Second)

	if openErr != nil {
		return openErr
	}

	r.Room.File.Pause = prevFilePause

	fmt.Println("move")
	r.SendRoomInfoAllClients()
	return nil
}

func (r *StreamRoom) Pause() error {
	r.Room.File.Pause = true
	fmt.Println("pause")
	r.SendRoomInfoAllClients()
	return nil
}

func (r *StreamRoom) Play() error {
	r.Room.File.Pause = false
	fmt.Println("play")
	r.SendRoomInfoAllClients()
	return nil
}

func (r *StreamRoom) RunWorker() {
	go func() {
		ticker := time.NewTicker(oggPageDuration)

		<-r.Room.File.Context.Done()
		fmt.Println("file loaded. start play")

		go func() {
			for ; true; <-time.NewTicker(time.Second).C {
				r.SendRoomInfoAllClients()
			}
		}()

		for ; true; <-ticker.C {

			if r.Room.File.Pause {
				continue
			}

			pageData, pageHeader, oggErr := r.Room.File.Reader.ParseNextPage()
			r.Room.File.Current += oggPageDuration
			r.Room.File.CurrentSeconds = float64(r.Room.File.Current) / float64(time.Second)
			if errors.Is(oggErr, io.EOF) {
				r.OnFileEnd()
				continue
			}

			if oggErr != nil {
				fmt.Println(oggErr)
				return
			}

			sampleCount := float64(pageHeader.GranulePosition - r.Room.File.LastGranule)
			r.Room.File.LastGranule = pageHeader.GranulePosition
			sampleDuration := time.Duration((sampleCount/48000)*1000) * time.Millisecond

			if oggErr = r.track.WriteSample(media.Sample{Data: pageData, Duration: sampleDuration}); oggErr != nil {
				fmt.Println(oggErr)
				return
			}
		}

	}()
}

func (r *StreamRoom) SendRoomInfoAllClients() {
	info := r.MakeStreamInfo()
	r.SendStructAllClients(info)
}

func (r *StreamRoom) SendDataAllClients(msg string) {
	for _, v := range r.clients {
		dc := v.DataChannel
		if dc == nil {
			continue
		}
		dc.SendText(msg)
	}
}
func (r *StreamRoom) SendStructAllClients(model interface{}) {
	ansver, err := json.Marshal(model)
	if err != nil {
		fmt.Println("error send struct", err)
		return
	}

	for _, v := range r.clients {
		dc := v.DataChannel
		if dc == nil {
			continue
		}
		dc.SendText(string(ansver))
	}
}

func (r *StreamRoom) DataChannelHandler(dc *webrtc.DataChannel, msg webrtc.DataChannelMessage, user *models.User) {

	var message models.TextMessage
	err := json.Unmarshal(msg.Data, &message)

	if err == nil && len(message.Id) > 0 {
		fmt.Printf("%#v\n", message)
		r.SendStructAllClients(message)
		return
	}

	var newPlaylist models.NewPlaylist
	err = json.Unmarshal(msg.Data, &newPlaylist)

	if err == nil && len(newPlaylist.Files) > 0 {
		fmt.Printf("%#v\n", newPlaylist)
		go worker.LoadRemoteAudio(newPlaylist, dc, r.WebRTC.Server)

		roomFiles := make([]*models.File, 0)

		for _, id := range newPlaylist.Files {
			file, err := r.WebRTC.Server.DataStorage.FileInterface.GetFile(id)
			if err != nil {
				continue
			}
			roomFiles = append(roomFiles, file)
		}
		r.Room.Playlist = roomFiles

		return
	}

}
func (r *StreamRoom) OnFileEnd() error {
	switch r.Room.Type {
	case models.RoomTypeSingle:
		return r.LoadFile(r.Room.File.File.Id)

	case models.RoomTypePlaylist:
		currentFileId := r.Room.File.File.Id
		files := r.Room.Playlist
		currentIndex := 0
		for i, f := range files {
			if currentFileId == f.Id {
				currentIndex = i
				break
			}
		}
		if currentIndex+1 >= len(files) {
			currentIndex = -1
		}

		nextFile := files[currentIndex+1]
		return r.LoadFile(nextFile.Id)

	default:
		r.Room.File.Pause = true
		return nil
	}

}

func FileDuration(path string) (time.Duration, error) {
	var FileDuration time.Duration

	file, openErr := os.Open(path)
	if openErr != nil {
		return FileDuration, openErr
	}

	ogg, _, openErr := oggreader.NewWith(file)
	if openErr != nil {
		return FileDuration, openErr
	}

	for {
		_, _, oggError := ogg.ParseNextPage()
		if oggError != nil {
			break
		}
		FileDuration += oggPageDuration
	}

	return FileDuration, nil
}
