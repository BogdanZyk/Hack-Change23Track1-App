package server

import (
	"gitlab.com/tatsiyev/audio-stream/migrations"
	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

func InitDatabase() (db *gorm.DB, err error) {
	db, err = gorm.Open(sqlite.Open("data.db"), &gorm.Config{Logger: logger.Discard})
	if err != nil {
		return nil, err
	}
	sqlDB, err := db.DB()
	if err != nil {
		return nil, err
	}
	err = migrations.Migrate(sqlDB)
	if err != nil {
		return nil, err
	}

	return db, nil
}
