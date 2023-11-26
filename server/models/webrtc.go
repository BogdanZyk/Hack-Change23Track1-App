package models

import (
	"time"
)

type SDP struct {
	Type string `json:"type"`
	SDP  string `json:"sdp"`
}

type WebRTCServerInterface interface {
	CreateRoom(*Room)
	DeleteRoom(string) error
	NewClient(string, *SDP, *User) (*SDP, error)
	LoadFile(string, string) error
	MoveFile(string, time.Duration) error
	Pause(string) error
	Play(string) error
}

type WebRTCRoomInterface interface {
	NewClient(*SDP, *User) (*SDP, error)
	LoadFile(string) error
	MoveFile(time.Duration) error
	Pause() error
	Play() error
	RunWorker()
}

type TextMessageType string

const (
	TextMessageType_Joined  = "joined"
	TextMessageType_Leaving = "leaving"
	TextMessageType_Message = "message"
	TextMessageType_Hiddent = "hidden"
)

type NewPlaylist struct {
	Files []string `json:"files"`
}

type FileStatus struct {
	Id     string `json:"id"`
	Status string `json:"status"`
}
type NewPlaylistStatus struct {
	Statuses []FileStatus `json:"statuses"`
}

type TextMessage struct {
	Id           string             `json:"id"`
	From         *User              `json:"from"`
	Type         TextMessageType    `json:"type"`
	Text         string             `json:"text"`
	ReplyMessage *ReplyMessage      `json:"reply_message"`
	Reactions    []*ReactionMessage `json:"reactions"`
	Sticker      string             `json:"sticker"`
}
type ReplyMessage struct {
	Id       string `json:"id"`
	Text     string `json:"text"`
	UserName string `json:"user_name"`
}
type ReactionMessage struct {
	From     *User  `json:"from"`
	Reaction string `json:"reaction"`
}
