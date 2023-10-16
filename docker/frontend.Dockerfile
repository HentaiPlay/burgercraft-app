# BUILD
FROM node:18.16.0 as build-stage
WORKDIR /
COPY burgercraft-app_frontend/package*.json .
COPY burgercraft-app_frontend/vite.config.ts .
RUN npm install
COPY burgercraft-app_frontend .
COPY .env .
RUN npm run build

# PROD
FROM nginx:1.19.0-alpine as production-stage
COPY --from=build-stage /dist /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]