## build

FROM node:20-alpine AS build

WORKDIR /app

COPY package.json ./
COPY package-lock.json ./

RUN npm ci

COPY . .

RUN npm run build

## prod

# Utilisateur non root avec unprivileged
FROM nginxinc/nginx-unprivileged:alpine AS production

USER root

RUN apk update && apk upgrade --no-cache brotli-libs curl libcurl libexpat libxslt musl musl-utils zlib

# Copie de la config nginx
COPY --chown=nginx:nginx nginx/nginx.conf /etc/nginx/templates/default.conf.template

# Copie des fichiers compilés par Vite
COPY --from=build --chown=nginx:nginx /app/dist /usr/share/nginx/html

USER nginx

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]