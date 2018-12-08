FROM nginx:alpine

COPY nginx.conf /etc/nginx/nginx.conf

ENV PORT 8080
EXPOSE 8080

COPY dist-${ENVIRONMENT}/* /usr/share/nginx/html

