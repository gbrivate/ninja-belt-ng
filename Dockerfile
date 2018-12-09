FROM node:9-slim

ENV PORT 8080
EXPOSE 8080
WORKDIR /usr/src/app

COPY . .

ARG environment

ENV environment start_${ENVIRONMENT:-local}

CMD ["npm", "run", "${environment}"]


