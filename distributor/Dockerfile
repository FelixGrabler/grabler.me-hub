# Build stage
FROM node:18-alpine AS build-stage

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Production stage
FROM node:18-alpine AS production-stage

WORKDIR /app

# Install production dependencies
COPY package*.json ./
RUN npm install --omit=dev

# Copy runtime files
COPY --from=build-stage /app/dist ./dist
COPY server.mjs ./server.mjs

ENV NODE_ENV=production
EXPOSE 80
CMD ["npm", "run", "start"]
