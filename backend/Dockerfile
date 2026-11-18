FROM node:20-alpine

ENV NODE_ENV=production

RUN apk update && apk upgrade --no-cache && addgroup -S appgroup && adduser -S -G appgroup appuser

WORKDIR /app
COPY --chown=appuser:appgroup package.json ./

# Dépendances de production uniquement et nettoyer le cache npm
RUN npm install --package-lock-only && npm ci --omit=dev && npm cache clean --force \
 && rm -rf /usr/local/lib/node_modules/npm /usr/local/bin/npm /usr/local/bin/npx

COPY --chown=appuser:appgroup . .

USER appuser

EXPOSE 3007

CMD ["node", "server.js"]