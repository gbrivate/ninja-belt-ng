FROM nginx:alpine

ENV PORT 8080
EXPOSE 8080

COPY nginx.conf /etc/nginx/nginx.conf

CMD ["ng build --env=${ENV}"]

COPY dist/* /usr/share/nginx/html
