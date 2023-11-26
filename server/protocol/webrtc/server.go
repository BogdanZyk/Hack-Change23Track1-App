package webrtc

import (
	"fmt"
	"time"

	"gitlab.com/tatsiyev/audio-stream/models"
)

type WebRTCServer struct {
	Server      *models.Server
	StreamRooms map[string]models.WebRTCRoomInterface
}

func NewWebRTCServer(s *models.Server) *WebRTCServer {
	return &WebRTCServer{
		Server:      s,
		StreamRooms: make(map[string]models.WebRTCRoomInterface),
	}
}

func (s *WebRTCServer) CreateRoom(room *models.Room) {
	streemRoom := NewStreemRoom(s, room)
	streemRoom.id = room.Id
	s.StreamRooms[room.Id] = streemRoom
	go s.StreamRooms[room.Id].RunWorker()
}

func (s *WebRTCServer) DeleteRoom(roomId string) error {
	_, ok := s.StreamRooms[roomId]
	if !ok {
		return fmt.Errorf("room not exist")
	}
	delete(s.StreamRooms, roomId)
	return nil
}

func (s *WebRTCServer) NewClient(roomId string, sdp *models.SDP, currentUser *models.User) (*models.SDP, error) {
	streemRoom, ok := s.StreamRooms[roomId]
	if !ok {
		return nil, fmt.Errorf("room not exist")
	}
	return streemRoom.NewClient(sdp, currentUser)
}

func (s *WebRTCServer) LoadFile(roomId string, fileId string) error {
	streemRoom, ok := s.StreamRooms[roomId]
	if !ok {
		return fmt.Errorf("room not exist")
	}
	return streemRoom.LoadFile(fileId)
}

func (s *WebRTCServer) MoveFile(roomId string, duration time.Duration) error {
	streemRoom, ok := s.StreamRooms[roomId]
	if !ok {
		return fmt.Errorf("room not exist")
	}
	return streemRoom.MoveFile(duration)
}

func (s *WebRTCServer) Pause(roomId string) error {
	streemRoom, ok := s.StreamRooms[roomId]
	if !ok {
		return fmt.Errorf("room not exist")
	}
	return streemRoom.Pause()
}

func (s *WebRTCServer) Play(roomId string) error {
	streemRoom, ok := s.StreamRooms[roomId]
	if !ok {
		return fmt.Errorf("room not exist")
	}
	return streemRoom.Play()
}
