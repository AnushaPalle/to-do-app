# # FROM nginx:1.23.3-alpine
# FROM alpine:3.14
# RUN apk add --update nodejs yarn
# WORKDIR /app
# COPY package.json .
# COPY yarn.lock .
# RUN yarn install  
# COPY . .
# # CMD export NODE_OPTIONS=--openssl-legacy-provider && yarn start
# CMD ["yarn", "start"]




#stage 1
FROM node:16.16.0-alpine3.15 as node
WORKDIR /app
COPY ./package.json /app
COPY . .
RUN yarn install
RUN yarn run build

FROM nginx
COPY --from=node /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf