# docker-twiki

A docker container to download and deploy twiki server based off of https://github.com/mharrend/docker-twiki

## Build
```
docker build -t twiki:6.1.0 -t twiki:latest .
```

The patch is based off of https://foswiki.org/pub/Tasks/Item15010/RCSStoreContrib.patch because the twiki hotfix was inaccessible. It's not perfect but fixes a lot of the errors in the configure backend.

## Run
```
docker run --rm -d -p 80:80 twiki:latest
```
