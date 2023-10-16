# BUILD FOR LOCAL DEVELOPMENT
FROM node:18.16-alpine As development
WORKDIR /usr/src/app
RUN apk update && apk add curl
COPY --chown=node:node burgercraft-app_backend/package*.json ./
COPY --chown=node:node burgercraft-app_backend/prisma ./prisma/
RUN rm -rf burgercraft-app_backend/dist
RUN npm ci
RUN npx prisma generate
COPY --chown=node:node burgercraft-app_backend .

# BUILD FOR PRODUCTION
FROM node:18.16-alpine As build
WORKDIR /usr/src/app
COPY --chown=node:node burgercraft-app_backend/package*.json ./
COPY --chown=node:node burgercraft-app_backend/prisma ./prisma/
COPY --chown=node:node --from=development /usr/src/app/node_modules ./burgercraft-app_backend/node_modules
COPY --chown=node:node burgercraft-app_backend .
RUN npm ci
RUN npm run build
ENV NODE_ENV production
RUN npm ci --only=production && npm cache clean --force

# PRODUCTION
FROM node:18.16-alpine As production
COPY --chown=node:node --from=build /usr/src/app/node_modules ./burgercraft-app_backend/node_modules
COPY --chown=node:node --from=build /usr/src/app/dist ./burgercraft-app_backend/dist
CMD ["node", "dist/main.js"]