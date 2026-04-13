package jwt

import (
	"fmt"

	"github.com/golang-jwt/jwt/v5"
)

var secretKey []byte

func SetSecretKey(key []byte) {
	secretKey = key
}

// GenerateToken generates a JWT token for a given username
func VerifyToken(tokenString string) bool {
	token, err := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, fmt.Errorf("unexpected signing method")
		}
		return secretKey, nil
	})

	return err == nil && token.Valid
}
