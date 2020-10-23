FROM node:14

EXPOSE 3000 3001

MAINTAINER Lucas <lucas.muoz@uc.cl>

WORKDIR /client

COPY package.json /client
COPY package-lock.json /client

RUN npm install

COPY . ./

CMD ["npm", "start"]


