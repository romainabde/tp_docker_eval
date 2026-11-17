FROM node:20-alpine

ENV NODE_ENV=production

RUN addgroup -S appgroup && adduser -S -G appgroup appuser

WORKDIR /app
COPY --chown=appuser:appgroup package.json ./

# Dépendances de production uniquement et nettoyer le cache npm
RUN npm install --package-lock-only && npm ci --omit=dev && npm cache clean --force

COPY --chown=appuser:appgroup . .

USER appuser

EXPOSE 3007

CMD ["node", "server.js"]