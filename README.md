# ethereum-explorer-docker

use https://github.com/gobitfly/etherchain-light/

## build

```
docker build -t ethereum-explorer-docker .
```

## run

Make sure your geth rpc was run on `GETH_HOST`, here is `localhost:8454`

```
docker run -d --name=ethereum-explorer \
-e GETH_HOST=localhost:8454 \
ethereum-explorer-docker 
```
