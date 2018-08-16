FROM library/alpine:latest

MAINTAINER "qyvlik@qq.com"

ENV NODE_VERSION 10.8.0
ENV GETH_HOST localhost

# Switch to root user
USER root

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
  && tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.xz" \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs \
  && npm install -g --registry=https://registry.npm.taobao.org bower \
  && npm install -g --registry=https://registry.npm.taobao.org gulp 

WORKDIR /home/www

RUN cd /home/www \
  && curl -SLO "https://github.com/etherparty/explorer/archive/master.zip" 
  && cd explorer \ 
  && npm install \
  && bower install

RUN chonw -R www:www /home/www

USER www

EXPOSE 8000

CMD ["http-server" "./app" "-a" "${GETH_HOST}" "-p" "8000" "-c-1" ]

