package models

import (
	"github.com/pion/webrtc/v4"
	"gitlab.com/tatsiyev/audio-stream/secret"
	"gorm.io/gorm"
)

type Server struct {
	TokenGenegator secret.TokenManager
	HashGenegator  secret.HashManager
	Database       *gorm.DB

	DataStorage  StorageInterface
	WebrtcServer WebRTCServerInterface

	CandidateSocket map[string]*CandidateSocketData
}

type CandidateSocketData struct {
	Recive chan webrtc.ICECandidateInit
	Send   chan webrtc.ICECandidateInit
}

func NewCandidateSocketData() *CandidateSocketData {
	return &CandidateSocketData{
		Recive: make(chan webrtc.ICECandidateInit, 3),
		Send:   make(chan webrtc.ICECandidateInit, 3),
	}
}
