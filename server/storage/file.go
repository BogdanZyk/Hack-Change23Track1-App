package storage

import (
	"fmt"

	"gitlab.com/tatsiyev/audio-stream/models"
)

type FilesStorage struct {
	Server *models.Server
}

func (s *FilesStorage) GetFiles() []*models.File {
	files := make([]*models.File, 0)

	s.Server.Database.Find(&files)

	return files
}

func (s *FilesStorage) SearchFiles(query string) []*models.File {
	files := make([]*models.File, 0)

	s.Server.Database.Where("name LIKE ?", fmt.Sprintf("%%%s%%", query)).Find(&files)

	return files
}

func (s *FilesStorage) GetFile(fileId string) (*models.File, error) {
	file := &models.File{}

	db := s.Server.Database.Where("id = ?", fileId).First(&file)

	return file, db.Error
}

func NewFileStorage(s *models.Server) models.FileInterface {
	return &FilesStorage{
		Server: s,
	}
}
