FROM nginx:alpine
FROM node:alpine

ENV PORT 8080
EXPOSE 8080


RUN npm install
RUN npm install @angular/cli -g
RUN ng build --env=${ENV}

COPY nginx.conf /etc/nginx/nginx.conf


