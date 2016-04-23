#!/bin/bash

docker run -it --rm --name php-mysql -p $1:80 -p $2:3306 -v /data/mysql/recomendacao:/data adalrsjr1/php-mysql
