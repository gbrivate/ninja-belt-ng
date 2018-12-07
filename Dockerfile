# The builder from node image
FROM node:alpine as builder

# build-time variables
# prod|staging its value will be come from outside
ARG env=prod

RUN apk update && apk add --no-cache make git

# Move our files into directory name "app"
WORKDIR /app

# Move our files into directory name "app"
WORKDIR /app
COPY package.json package-lock.json  /app/
RUN npm install @angular/cli@6.0.8 -g
RUN cd /app && npm install
COPY .  /app


# Build with $env variable from outside
RUN cd /app && npm run build

# Build a small nginx image with static website
FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /app/dist /usr/share/nginx/html
ENV PORT 8080
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]


