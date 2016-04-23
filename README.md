# adalrsjr1/php-mysql

Multiple purpose Apache and PHP image based on Alpine

Image is based on the [gliderlabs/alpine](https://registry.hub.docker.com/u/gliderlabs/alpine/) base image

## Docker image usage

```
docker run [docker-options] adalrsjr1/php-mysql
```

## Examples

Typical basic usage:

```
docker run -it --rm -p 80:80 -p 3306:3306 -v /data/mysql/<db_folder>:/data adalrsjr1/php-mysql
```

Typical usage in Dockerfile:

```
app: folder with the application (php) files

```


