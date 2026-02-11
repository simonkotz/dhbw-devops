package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/simonkotz/dhbw-devops/internal/auth"
	"github.com/simonkotz/dhbw-devops/internal/checkout"
	"github.com/simonkotz/dhbw-devops/internal/product"
)

var secretKey = []byte("secret-key")

type Product struct {
	ID    int     `json:"id"`
	Name  string  `json:"name"`
	Price float64 `json:"price"`
}

// Static data for three products
var products = []Product{
	{ID: 1, Name: "Product 1", Price: 19.99},
	{ID: 2, Name: "Product 2", Price: 29.99},
	{ID: 3, Name: "Product 3", Price: 39.99},
}

func main() {
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
