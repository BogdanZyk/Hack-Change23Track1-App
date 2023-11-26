package secret

import (
	"crypto/sha512"
	"encoding/hex"
)

type HashManager interface {
	Generate(data string) string
}

type HashManagerImpl struct {
	Generator func(data string) string
}

func (m *HashManagerImpl) Generate(data string) string {
	return m.Generator(data)
}

func NewHashManager(salt string) HashManager {
	g := func(data string) string { return GenerateHash(salt, data) }
	return &HashManagerImpl{Generator: g}
}

func GenerateHash(salt, data string) string {
	hashByte := sha512.Sum512([]byte(data + salt))
	hash := hex.EncodeToString(hashByte[:])
	return hash
}
