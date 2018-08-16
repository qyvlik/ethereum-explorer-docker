FROM node:alpine

MAINTAINER "qyvlik@qq.com"

ENV GETH_HOST localhost

# Switch to root user
USER root

RUN npm install -g --registry=https://registry.npm.taobao.org bower \
  && npm install -g --registry=https://registry.npm.taobao.org gulp 

WORKDIR /home/www

USER www

RUN chonw -R www:www /home/www \
  && cd /home/www \
  && wget "https://github.com/etherparty/explorer/archive/master.zip" \
  && unzip master.zip \
  && cd explorer-master \ 
  && npm install \
  && bower install --allow-root


EXPOSE 8000

CMD ["http-server" "./app" "-a" "${GETH_HOST}" "-p" "8000" "-c-1" ]

