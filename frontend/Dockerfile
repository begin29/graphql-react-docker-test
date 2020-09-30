FROM node:alpine

RUN mkdir -p /usr/src/frontend-app
WORKDIR /usr/src/frontend-app

COPY package.json /usr/src/frontend-app

RUN yarn install

COPY . /usr/src/frontend-app

CMD ["yarn", "run", "start"]
