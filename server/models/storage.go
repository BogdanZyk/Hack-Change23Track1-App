package models

import (
	"context"
	"time"

	"github.com/pion/webrtc/v4/pkg/media/oggreader"
)

type StorageInterface struct {
	RoomInterface
	FileInterface
	UserInterface
	StickerInterface
}

type RoomInterface interface {
	GetRooms() []*Room
	GetRoom(roomId string) (*Room, error)
	GetRoomByKey(key string) (*Room, error)
	CreateRoom(args *Room) *Room
	Action(roomId, action, argument string) (*Room, error)
	DeleteRoom(roomId string) error
	UpdateRoom(roomId string, args *Room) (*Room, error)
	OpenFile(roomId string, fileId string) (*Room, error)
}

type FileInterface interface {
	GetFiles() []*File
	SearchFiles(query string) []*File
	GetFile(fileId string) (*File, error)
}

type UserInterface interface {
	SignIn(email, password string) (token string, err error)
	SignUp(email, login, password string) (token string, err error)
	CurrnetUser(token string) (*User, error)
	UpdateUser(userId string, args *User) (*User, error)
}

type StickerInterface interface {
	GetAllStickers() []*StickerPack
}

type RoomType string

var (
	RoomTypeNone     RoomType = "NO_TYPE"
	RoomTypeSingle   RoomType = "SINGLE"
	RoomTypePlaylist RoomType = "PLAYLIST"
)

type Room struct {
	Id    string `json:"id"`
	Name  string `json:"name"`
	Key   string `json:"key"`
	Image string `json:"image"`
	Likes int64  `json:"likes"`

	Private bool `json:"private"`
	Type    RoomType

	File     *PlayFile        `json:"file"`
	Users    map[string]*User `json:"users"`
	Members  []*User          `json:"members"`
	Owner    *User            `json:"owner"`
	Playlist []*File          `json:"playlist"`
}

type File struct {
	Id    string `json:"id"`
	Name  string `json:"name"`
	Path  string `json:"path"`
	Cover string `json:"cover"`
}

func (f *File) TableName() string {
	return "audio"
}

type PlayFile struct {
	File            *File                `json:"file"`
	Reader          *oggreader.OggReader `json:"-"`
	Context         context.Context      `json:"-"`
	ContextCancel   context.CancelFunc   `json:"-"`
	LastGranule     uint64               `json:"-"`
	Pause           bool                 `json:"pause"`
	Duration        time.Duration        `json:"duration"`
	Current         time.Duration        `json:"current"`
	DurationSeconds float64              `json:"duration_seconds"`
	CurrentSeconds  float64              `json:"current_seconds"`
}

type User struct {
	Id           string `json:"id"`
	Avatar       string `json:"avatar"`
	Email        string `json:"email"`
	Login        string `json:"login"`
	Password     string `json:"-" gorm:"-"`
	PasswordHash string `json:"-"`
}

type StickerPack struct {
	Name     string   `json:"name"`
	Stickers []string `json:"stickers"`
}

type Sticker struct {
	Id  string `json:"id"`
	Url string `json:"url"`
}
