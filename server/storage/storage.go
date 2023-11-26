package storage

import (
	"encoding/base64"
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/google/uuid"
	"gitlab.com/tatsiyev/audio-stream/models"
)

type Storage struct {
	models.RoomInterface
	models.FileInterface
	models.UserInterface
	models.StickerInterface
}

func NewStorage(s *models.Server) models.StorageInterface {
	storage := models.StorageInterface(
		Storage{
			RoomInterface:    NewRoomStorage(s),
			FileInterface:    NewFileStorage(s),
			UserInterface:    NewUserStorage(s),
			StickerInterface: NewStickerStorage(s),
		},
	)
	return storage
}

func SaveBase64File(b64Inp, folder string) (string, error) {
	id := uuid.NewString()
	filename := fmt.Sprintf("/uploads/%s/%s.png", folder, id)

	inp := strings.Split(b64Inp, ",")
	b64 := inp[len(inp)-1]

	dec, err := base64.StdEncoding.DecodeString(b64)
	if err != nil {
		return "", err
	}

	exPath, err := os.Executable()
	if err != nil {
		return "", err
	}
	path := filepath.Dir(exPath)

	err = os.MkdirAll(fmt.Sprintf("%s/public/uploads/%s", path, folder), 0755)
	if err != nil {
		return "", err
	}
	f, err := os.Create(fmt.Sprintf("%s/public%s", path, filename))
	if err != nil {
		return "", err
	}
	defer f.Close()
	if _, err := f.Write(dec); err != nil {
		return "", err
	}
	if err := f.Sync(); err != nil {
		return "", err
	}
	return filename, nil
}
