package product

import (
	"encoding/json"
	"net/http"
	"strconv"
)

func ProductListHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodGet {
		http.Error(w, "Method Not Allowed", http.StatusMethodNotAllowed)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	response, err := json.Marshal(products)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(`{"error": "Internal Server Error"}`))
		return
	}
	w.Write(response)
}

func ProductDetailHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodGet {
		http.Error(w, "Method Not Allowed", http.StatusMethodNotAllowed)
		return
	}

	w.Header().Set("Content-Type", "application/json")

	idStr := r.PathValue("id")

	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, `{"error":"Product ID has wrong format"}`, http.StatusBadRequest)
		return
	}

	product := findProductByID(products, id)
	if product == nil {
		http.Error(w, `{"error":"Product not found"}`, http.StatusNotFound)
		return
	}

	resp, err := json.Marshal(product)
	if err != nil {
		http.Error(w, `{"error":"Internal Server Error"}`, http.StatusInternalServerError)
		return
	}

	w.Write(resp)
}

func findProductByID(products []Product, id int) *Product {
	for _, product := range products {
		if product.ID == id {
			return &product
		}
	}
	return nil
}
