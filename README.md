# Grabler.me Hub

Landing page (`distributor`) plus a shared Nginx proxy that routes traffic to the app containers already running on the `grabler-network` Docker network.

## What lives here

- `distributor/`: grabler.me landing page (Vue + Nginx)
- `proxy/`: Nginx configs (prod + dev)
- `docker-compose.yml` / `docker-compose.dev.yml`: start only the proxy and distributor
- `Makefile`: helper commands

Your app containers (`felix`, `mama-rezepte`, `mama-rezepte-backend`, `namo-frontend`, `namo-backend`) run from their own repos/images; just attach them to the shared `grabler-network`.

## Quick start

```bash
# once per machine
docker network create grabler-network

# development (proxy on 8080, distributor on 3000)
make dev

# production-style (proxy on 80 and direct Felix access on 8040)
make prod
```

## URLs

- Main hub: `http://localhost:8080` (dev) or `http://<server-ip>` (prod)
- Felix proxied: `http://felix.localhost:8080` (dev) or `https://felix.grabler.me` (prod)
- Felix direct port: `http://localhost:8040` (hits the `felix` container on the shared network)
- MamaRezepte proxied: `http://rezepte.localhost:8080` (dev) / `https://rezepte.grabler.me` (prod)
- Namo proxied: `http://namo.localhost:8080` (dev) / `https://namo.grabler.me` (prod)

## Attaching other projects

Run each project independently and join the shared network, for example:

```bash
docker run --rm -d --name felix --network grabler-network felix-image:latest
```

The proxy forwards based on container names:

- `felix.grabler.me` and port `8040` -> container `felix` on port 80
- `rezepte.grabler.me` -> `mama-rezepte` on port 80 and `mama-rezepte-backend` on port 8000 for `/api/`
- `namo.grabler.me` -> `namo-frontend` on port 80 and `namo-backend` on port 8000 for `/api/`

## Commands

- `make dev` / `make dev-down` / `make logs-dev` / `make restart-dev`
- `make prod` / `make prod-down` / `make logs` / `make restart`
- `make clean` (stop and prune hub containers/images/volumes)
- `make show-urls` (quick reference to domains/ports)
