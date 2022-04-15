#!/bin/sh

docker-compose up -d
./composer.sh install
docker-compose exec php chown -R www-data:www-data /var/www/html/web/assets
docker-compose exec php chown -R www-data:www-data /var/www/html/runtime
docker-compose exec php chown -R www-data:www-data /var/www/html/runtime/cache
sleep 30
#docker-compose exec db sh -c 'echo "ALTER DATABASE yii CHARACTER SET utf8 COLLATE utf8_general_ci;" | mysql'

./yii.sh migrate --interactive=0
./yii.sh init

