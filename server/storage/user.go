package storage

import (
	"fmt"
	"sync"

	"github.com/google/uuid"
	"gitlab.com/tatsiyev/audio-stream/models"
)

type MemoryUsers struct {
	Users      map[string]*models.User
	RoomsMutex sync.RWMutex

	Server *models.Server
}

func (u *MemoryUsers) SignIn(email, password string) (token string, err error) {
	passHash := u.Server.HashGenegator.Generate(password)
	var user *models.User
	db := u.Server.Database.Where(map[string]string{"email": email, "password_hash": passHash}).First(&user)
	if db.Error != nil {
		return "", db.Error
	}

	token = u.Server.TokenGenegator.Sign(int64(30*24*60*60), map[string]string{"id": user.Id})
	return token, nil
}

func (u *MemoryUsers) SignUp(email, login, password string) (token string, err error) {
	passHash := u.Server.HashGenegator.Generate(password)
	id := uuid.NewString()

	var user *models.User
	db := u.Server.Database.Where(map[string]string{"email": email}).First(&user)

	if db.Error == nil {
		return "", fmt.Errorf("login exist")
	}

	user = &models.User{Id: id, Email: email, Login: login, PasswordHash: passHash}
	db = u.Server.Database.Create(&user)
	if db.Error != nil {
		return "", db.Error
	}

	token = u.Server.TokenGenegator.Sign(int64(30*24*60*60), map[string]string{"id": user.Id})
	return token, nil
}

func (u *MemoryUsers) CurrnetUser(token string) (*models.User, error) {
	claims, err := u.Server.TokenGenegator.Verify(token)
	if err != nil {
		return nil, err
	}
	id, exist := claims["id"]
	if !exist {
		return nil, fmt.Errorf("invalid token")
	}

	var user *models.User
	db := u.Server.Database.Where(map[string]string{"id": id}).First(&user)
	if db.Error != nil {
		return nil, db.Error
	}
	return user, nil
}

func (u *MemoryUsers) UpdateUser(userId string, args *models.User) (*models.User, error) {
	db := u.Server.Database.Where(map[string]string{"id": userId}).Updates(args)
	if db.Error != nil {
		return nil, db.Error
	}
	var user *models.User
	db = u.Server.Database.Where(map[string]string{"id": userId}).First(&user)
	return user, db.Error
}

func NewUserStorage(s *models.Server) models.UserInterface {
	return &MemoryUsers{
		Server: s,
		Users:  make(map[string]*models.User),
	}
}
