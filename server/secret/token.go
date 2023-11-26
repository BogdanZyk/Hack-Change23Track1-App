package secret

import (
	"context"
	"encoding/base64"
	"time"

	"github.com/lestrrat-go/jwx/v2/jwa"
	"github.com/lestrrat-go/jwx/v2/jwt"
)

type TokenManager interface {
	Generate(data string) string
	Verify(token string) (map[string]string, error)
	Sign(duration int64, claims map[string]string) string
}

type TokenManagerImpl struct {
	Generator   func(duration int64, claims map[string]string) string
	Verificator func(token string) (map[string]string, error)
}

func (m *TokenManagerImpl) Generate(data string) string {
	return m.Generator(int64(time.Hour), map[string]string{"subject": data})
}
func (m *TokenManagerImpl) Verify(token string) (map[string]string, error) {
	return m.Verificator(token)
}
func (m *TokenManagerImpl) Sign(duration int64, claims map[string]string) string {
	return m.Generator(duration, claims)
}

func NewTokenManager(sign string) TokenManager {
	secret, _ := base64.StdEncoding.DecodeString(sign)

	gen := func(duration int64, claims map[string]string) string { return Sign(secret, duration, claims) }
	ver := func(token string) (map[string]string, error) { return Verify(secret, token) }

	return &TokenManagerImpl{Generator: gen, Verificator: ver}
}

func Sign(secret []byte, duration int64, claims map[string]string) string {
	builder := jwt.NewBuilder().
		Issuer("audio_stream_server").
		IssuedAt(time.Now()).
		Expiration(time.Now().Add(time.Duration(duration) * time.Second))

	for field, value := range claims {
		builder.Claim(field, value)
	}

	tok, _ := builder.Build()

	signed, _ := jwt.Sign(tok, jwt.WithKey(jwa.HS512, secret))

	return string(signed)
}

func Verify(secret []byte, token string) (map[string]string, error) {
	jwt, e := jwt.Parse([]byte(token), jwt.WithKey(jwa.HS512, secret))
	if e != nil {
		return nil, e
	}

	claimsMap, _ := jwt.AsMap(context.Background())
	claims := make(map[string]string)

	for field, value := range claimsMap {
		v, ok := value.(string)
		if ok {
			claims[field] = v
		}
	}

	return claims, nil
}
