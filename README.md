# confd-haproxy


## Build as root

`docker build -t confd-haproxy:0.4-root --build-arg CONFD_USER=root --build-arg CONFD_GROUP=root .`

## Build as nobody

`docker build -t confd-haproxy:0.4-nobody --build-arg CONFD_USER=nobody --build-arg CONFD_GROUP=nogroup .`
