package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/simonkotz/dhbw-devops/checkout-service/internal/checkout"
	"github.com/simonkotz/dhbw-devops/checkout-service/pkg/jwt"
)

func main() {

	jwt.SetSecretKey([]byte("secret-key"))

	mux := http.NewServeMux()

	mux.HandleFunc("/checkout/placeorder", checkout.CheckoutPlaceOrderHandler)

	port := 8080
	log.Printf("Server is running on port %d...\n", port)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%d", port), mux))
}
