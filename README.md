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
- `POST /checkout` - Bestellung abschließen (benötigt Authentifizierung)


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
