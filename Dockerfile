FROM nginx:alpine

COPY nginx.conf /etc/nginx/nginx.conf

ENV PORT 8080
EXPOSE 8080

RUN mkdir -p /d

ARG dist=dist-${ENVIRONMENT}

COPY ${dist}* /usr/share/nginx/html/

