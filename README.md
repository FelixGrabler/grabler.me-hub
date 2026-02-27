# Grabler.me Hub

Landing page (`distributor`) plus a shared Nginx proxy that routes traffic to app containers on the `grabler-network` Docker network.

## What lives here

- `distributor/`: grabler.me frontend (Vue build) + `/telegram` relay endpoint
- `proxy/`: Nginx production config
- `docker-compose.yml`: production stack
- `Makefile`: helper commands

Your app containers (`felix`, `mamarezepte-frontend`, `namo-frontend`, `namo-backend`, `fisch`) run from their own repos/images; just attach them to the shared `grabler-network`.
This stack now also hosts a shared auth service (`shared-auth`) plus its own Postgres database for cross-project user accounts.
The auth API is intended for internal Docker-network use by sibling services, not public browser access.

## Quick start

```bash
# once per machine
docker network create grabler-network

# generate shared auth + sibling app secrets
./scripts/generate-shared-secrets.sh

# configure Telegram relay
cp .env.example .env

# production stack (proxy on 8090)
make up
```

## URLs

- Main hub: `https://grabler.me`
- Subpages:
  - `https://grabler.me/impressum`
  - `https://grabler.me/dsgvo`
  - `https://grabler.me/feedback`
- Felix proxied: `https://felix.grabler.me`
- Felix direct port: `http://<server-ip>:8010`
- MamaRezepte proxied: `https://rezepte.grabler.me`
- Namo proxied: `https://namo.grabler.me`
- Fisch proxied: `https://fisch.grabler.me`
- Link shortener: `https://go.grabler.me`

## Attaching other projects

Run each project independently and join the shared network, for example:

```bash
docker run --rm -d --name felix --network grabler-network felix-image:latest
```

The proxy forwards based on container names:

- `felix.grabler.me` and port `8040` -> container `felix` on port 80
- `rezepte.grabler.me` -> `mama-rezepte` on port 80 and `mama-rezepte-backend` on port 8000 for `/api/`
- `namo.grabler.me` -> `namo-frontend` on port 80 and `namo-backend` on port 8000 for `/api/`
- `go.grabler.me` -> `go-shortener` on port 8000

## Commands

- `make up` / `make down` / `make logs` / `make restart`
- `make prod` / `make prod-down` (aliases)
- `make clean` (stop and prune hub containers/images/volumes)
- `make show-urls` (quick reference to domains/ports)
