FROM node:8

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm install --only=production

# Bundle app source
COPY . .

ENV PORT 8080
EXPOSE 8080

ARG env=start_${ENVIRONMENT:-local}"

RUN echo ${env}

CMD ["sh", "-c", " npm run ${env}"]


