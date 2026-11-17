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

# Copie de la config nginx
COPY --chown=nginx:nginx nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Copie des fichiers compilés par Vite
COPY --from=build --chown=nginx:nginx /app/dist /usr/share/nginx/html

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]