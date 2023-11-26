package storage

import (
	"fmt"
	"strconv"
	"sync"
	"time"

	"gitlab.com/tatsiyev/audio-stream/models"
)

type MemoryRooms struct {
	Server     *models.Server
	Rooms      map[string]*models.Room
	RoomsMutex sync.RWMutex
}

func (s *MemoryRooms) GetRooms() []*models.Room {
	rooms := make([]*models.Room, 0)
	s.RoomsMutex.Lock()
	defer s.RoomsMutex.Unlock()
	for _, r := range s.Rooms {
		if r.Private {
			continue
		}

		r.Members = make([]*models.User, 0)
		for _, u := range r.Users {
			r.Members = append(r.Members, u)
		}
		rooms = append(rooms, r)
	}
	return rooms
}

func (s *MemoryRooms) GetRoom(id string) (*models.Room, error) {
	s.RoomsMutex.Lock()
	defer s.RoomsMutex.Unlock()

	room, ok := s.Rooms[id]
	if !ok {
		return nil, fmt.Errorf("not exist")
	}

	room.Members = make([]*models.User, 0)
	for _, u := range room.Users {
		room.Members = append(room.Members, u)
	}

	return room, nil
}

func (s *MemoryRooms) GetRoomByKey(key string) (*models.Room, error) {
	s.RoomsMutex.Lock()
	defer s.RoomsMutex.Unlock()
	var room *models.Room
	for _, r := range s.Rooms {
		if r.Key == key {
			room = r
			break
		}
	}
	if room == nil {
		return nil, fmt.Errorf("room not found")
	}
	return room, nil
}

func (s *MemoryRooms) CreateRoom(room *models.Room) *models.Room {
	room.Id = models.RandSeq(6)
	room.Key = models.RandSeq(6)
	room.Users = make(map[string]*models.User)

	s.RoomsMutex.Lock()
	s.Rooms[room.Id] = room
	s.RoomsMutex.Unlock()

	s.Server.WebrtcServer.CreateRoom(room)

	return room
}

func (s *MemoryRooms) UpdateRoom(roomId string, args *models.Room) (*models.Room, error) {
	room, ok := s.Rooms[roomId]
	if !ok {
		return nil, fmt.Errorf("not exist")
	}

	if args.Name != "" {
		room.Name = args.Name
	}
	if args.Image != "" {
		room.Image = args.Image
	}
	if args.Private != room.Private {
		room.Private = args.Private
	}
	if args.Type != "" {
		room.Type = args.Type
	}
	return room, nil
}

func (s *MemoryRooms) DeleteRoom(roomId string) error {
	s.RoomsMutex.Lock()
	defer s.RoomsMutex.Unlock()

	delete(s.Rooms, roomId)
	return s.Server.WebrtcServer.DeleteRoom(roomId)
}

func (s *MemoryRooms) Action(roomId, action, argument string) (*models.Room, error) {
	s.RoomsMutex.Lock()
	room, ok := s.Rooms[roomId]
	s.RoomsMutex.Unlock()

	if !ok {
		return nil, fmt.Errorf("room not exist")
	}

	switch action {
	case "pause":
		err := s.Server.WebrtcServer.Pause(roomId)
		return room, err
	case "play":
		err := s.Server.WebrtcServer.Play(roomId)
		return room, err
	case "move":
		val, err := strconv.ParseFloat(argument, 64)
		if err != nil {
			return nil, err
		}

		duration := val * float64(time.Second)
		err = s.Server.WebrtcServer.MoveFile(roomId, time.Duration(duration))
		return room, err
	}

	return room, nil
}

func (s *MemoryRooms) OpenFile(roomId, fileId string) (*models.Room, error) {
	err := s.Server.WebrtcServer.LoadFile(roomId, fileId)
	if err != nil {
		return nil, err
	}
	room, err := s.GetRoom(roomId)
	if err != nil {
		return nil, err
	}
	return room, nil
}

func NewRoomStorage(s *models.Server) models.RoomInterface {
	return &MemoryRooms{
		Server: s,
		Rooms:  make(map[string]*models.Room),
	}
}
