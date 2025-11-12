# Etapa 1: construir dependencias
FROM node:20-alpine AS build

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci --omit=dev
COPY . .

# Etapa 2: imagen liviana para ejecutar
FROM node:20-alpine

WORKDIR /usr/src/app
COPY --from=build /usr/src/app ./

EXPOSE 3000
CMD ["node", "server.js"]