# devops-lecture-project-2025

Projekt für die Vorlesung "Einführung in DevOps, Continuous Delivery Tools und Mindset" an der DHBW.


## Übersicht

Diese Anwendung ist ein einfaches E-Commerce-Backend, das die grundlegenden Funktionen eines Webshops implementiert. Das Projekt dient als Demonstrationsobjekt für DevOps-Praktiken wie Containerisierung, CI/CD und Deployment.


## Features

- **Authentifizierung**: JWT-basierte Benutzerauthentifizierung
- **Produktverwaltung**: REST-API zum Abrufen von Produktinformationen
- **Checkout-Funktionalität**: Endpoint zum Abschließen von Bestellungen
- **Containerisierung**: Docker-Support mit Alpine Linux Basis-Image


## API-Endpunkte

### Authentifizierung
- `POST /auth/login` - Benutzeranmeldung und JWT-Token-Generierung

### Produkte
- `GET /products` - Produktliste abrufen
- `GET /products/{id}` - Einzelnes Produkt abrufen

### Bestellung
- `POST /checkout/placeorder` - Bestellung abschließen (benötigt Authentifizierung)


## Kubernetes-Funktionalität

Die folgenden Befehle deployen alle Services in den Namespace `devops-lecture`, prüfen den Zustand und testen die Selbstheilung von Kubernetes.

```bash
# 1) Namespace anlegen
kubectl apply -f k8s/namespace.yaml

# 2) Deployments + Services ausrollen
kubectl apply -n devops-lecture -f k8s/auth-service.yaml
kubectl apply -n devops-lecture -f k8s/checkout-service.yaml
kubectl apply -n devops-lecture -f k8s/product-service.yaml

# 3) Überblick über laufende Pods und Services
kubectl get pods,svc -n devops-lecture
```

### Selbstheilung (Self-Healing) demonstrieren

Wenn alle Pods gelöscht werden, erstellt das Deployment automatisch neue Pods mit der gewünschten Replikazahl.

```bash
# Alle Pods im Namespace löschen
kubectl delete pod --all -n devops-lecture

# Neuaufbau in Echtzeit beobachten
kubectl get pods -n devops-lecture -w
```

### API lokal testen per Port-Forward

Mit Port-Forward wird der Service aus dem Cluster auf `localhost` verfügbar gemacht.

```bash
# Auth-Service lokal auf Port 8080 erreichbar machen
kubectl port-forward -n devops-lecture svc/auth-service 8080:80

# Login-Endpoint testen
curl -X POST -d "username=user&password=pass" http://localhost:8080/auth/login
```


### Mit Docker ausführen

1. Image bauen:
   ```bash
   docker build -f Dockerfile.alpine -t devops-lecture .
   ```

2. Container starten:
   ```bash
   docker run -p 8080:8080 devops-lecture
   ```

## Docker Image

Ein vorkonfiguriertes Docker-Image ist auf Docker Hub verfügbar:

```bash
docker pull sktz/devops-lecture:latest
```

Alle verfügbaren Versionen und weitere Informationen auf [Docker Hub](https://hub.docker.com/repository/docker/sktz/devops-lecture/general).
