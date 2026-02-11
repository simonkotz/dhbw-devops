package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/simonkotz/dhbw-devops/internal/auth"
	"github.com/simonkotz/dhbw-devops/internal/checkout"
	"github.com/simonkotz/dhbw-devops/internal/product"
	"github.com/simonkotz/dhbw-devops/pkg/jwt"
)

func main() {

	jwt.SetSecretKey([]byte("secret-key"))

	mux := http.NewServeMux()
	// Auth Service
	mux.HandleFunc("/auth/login", auth.AuthLoginHandler)
	mux.HandleFunc("/auth/logout", auth.AuthLogoutHandler)
	// Product Service
	mux.HandleFunc("/products", product.ProductListHandler)
	mux.HandleFunc("/products/{id}", product.ProductDetailHandler)
	// Checkout Service
	mux.HandleFunc("/checkout/placeorder", checkout.CheckoutPlaceOrderHandler)
	port := 8080
	log.Printf("Server is running on port %d...\n", port)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%d", port), mux))
}
