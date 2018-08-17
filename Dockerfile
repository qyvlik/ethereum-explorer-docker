FROM node:alpine

MAINTAINER "qyvlik@qq.com"

ENV GETH_HOST localhost

# Switch to root user
USER root

RUN apk add git \
  && apk add python \
  && rm -rf /var/cache/apk/* \
  && npm install -g --registry=https://registry.npm.taobao.org bower \
  && npm install -g --registry=https://registry.npm.taobao.org gulp \
  && mkdir -p /home/www \
  && wget "https://github.com/gobitfly/etherchain-light/archive/master.zip" \
  && unzip master.zip \
  && cd etherchain-light-master \ 
  && npm install \
  && bower install --allow-root 

ADD config.js /home/www/etherchain-light-master/config.js

WORKDIR /home/www/etherchain-light-master

RUN adduser -D -u 1001 www www \
  && chown -R www:www /home/www

USER www

EXPOSE 8000

CMD ["npm", "start"]

