package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/simonkotz/dhbw-devops/auth-service/internal/auth"
	"github.com/simonkotz/dhbw-devops/auth-service/pkg/jwt"
)

func main() {

	// Set the secret key for JWT token generation and verification
	jwt.SetSecretKey([]byte("secret-key"))

	mux := http.NewServeMux()

	// Auth Service Functionality
	mux.HandleFunc("/auth/login", auth.AuthLoginHandler)
	mux.HandleFunc("/auth/logout", auth.AuthLogoutHandler)

	port := 8080
	log.Printf("Server is running on port %d...\n", port)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%d", port), mux))
}
