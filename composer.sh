#!/bin/sh

docker-compose exec php sh -c "cd /var/www/html; composer --prefer-dist $*"

