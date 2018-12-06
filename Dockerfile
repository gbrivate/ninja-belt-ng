FROM nginx:alpine
FROM node:alpine

ENV PORT 8080
EXPOSE 8080

COPY nginx.conf /etc/nginx/nginx.conf

RUN npm install
RUN npm install @angular/cli -g
RUN ng build --env=${ENV}

COPY dist/* /usr/share/nginx/html
