FROM node:alpine

MAINTAINER "qyvlik@qq.com"

ENV GETH_HOST localhost

# Switch to root user
USER root

WORKDIR /home/www

RUN apk add git \
  && apk add python \
  && rm -rf /var/cache/apk/* \
  && npm install -g --registry=https://registry.npm.taobao.org bower \
  && npm install -g --registry=https://registry.npm.taobao.org gulp \
  && wget "https://github.com/etherparty/explorer/archive/master.zip" \
  && unzip master.zip \
  && cd explorer-master \ 
  && npm install \
  && bower install --allow-root \
  && adduser -D -u 1000 www www \
  && chown -R www:www /home/www

USER www

EXPOSE 8000

CMD ["http-server" "./app" "-a" "${GETH_HOST}" "-p" "8000" "-c-1" ]

