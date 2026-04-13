package jwt

import (
	"fmt"

	"github.com/golang-jwt/jwt/v5"
)

var secretKey []byte

func SetSecretKey(key []byte) {
	secretKey = key
}

// VerifyToken checks if the provided JWT token is valid and was signed with the correct secret key.
func VerifyToken(tokenString string) bool {
	token, err := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, fmt.Errorf("unexpected signing method")
		}
		return secretKey, nil
	})

	return err == nil && token.Valid
}
