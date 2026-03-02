package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/simonkotz/dhbw-devops/product-service/internal/product"
)

func main() {
	log.Printf("Product Service v1.2.0 starting...\n")

	mux := http.NewServeMux()
	// Product Service
	mux.HandleFunc("/products", product.ProductListHandler)
	mux.HandleFunc("/products/{id}", product.ProductDetailHandler)

	port := 8080
	log.Printf("Server is running on port %d...\n", port)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%d", port), mux))
}
