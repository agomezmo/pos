FROM node:22-alpine AS build
WORKDIR /app
COPY package.json tsconfig.json ./
RUN npm install
COPY src ./src
RUN npx tsc

FROM node:22-alpine
WORKDIR /app

# Chromium for whatsapp-web.js (QR-based WhatsApp)
RUN apk add --no-cache \
  chromium \
  tzdata \
  font-noto \
  font-noto-cjk \
  font-noto-emoji \
  && rm -rf /var/cache/apk/*

# Skip puppeteer's own Chromium download
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV CHROME_PATH=/usr/bin/chromium-browser

COPY --from=build /app/dist ./dist
COPY --from=build /app/node_modules ./node_modules
COPY package.json ./
ENV NODE_ENV=production
EXPOSE 4000
CMD ["node", "dist/index.js"]
