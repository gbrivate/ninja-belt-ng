FROM nginx:alpine
FROM node:alpine

ENV PORT 8080
EXPOSE 8080

# Create app directory
RUN mkdir -p /src/app
WORKDIR /src/app

# Install app dependencies
COPY package.json /src/app/
RUN npm install
RUN npm install @angular/cli -g

# Bundle app source
COPY . /src/app

# Build and optimize react app
RUN npm run build

COPY nginx.conf /etc/nginx/nginx.conf

COPY dist/ninja-belt-ng/* /usr/share/nginx/html
