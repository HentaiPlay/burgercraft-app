FROM nginx:stable-alpine
COPY ./burgercraft_app.conf ./etc/nginx/conf.d/default.conf
CMD ["nginx", "-g", "daemon off;"]