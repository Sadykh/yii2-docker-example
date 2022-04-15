# Развертывание проекта


Данный репозиторий создан с целью демонстрации, как можно использовать его с docker и yii2


Запуск docker
---
1. Сначала нужно пройти поиском по проекту и заменить везде ``changeme`` на другие значения.
Например в docker-compose.yaml: changeme_php => project_php, и тд, чтобы было понятно что за проект запущен в докер
2. Создать файл .env в корне проекта с содержимым типа .env-dist, changeme поменять перед вставкой
3. Затем нужно выполнить команду ``docker-compose up -d`` и ждать пока все контейнеры будут подняты. 
4. В контейнере с базой данных будет поднята база с реквизитами из .env

Первая установка yii2
---

Затем нам нужно установить yii2 в контейнере php.

1. Входим в контейнер:
``docker exec -it changeme_php bash``, не забываем про changeme_php. Также можно просто ``make php``
2. Поднимаемся из каталога ``/var/www/html`` на уровень выше, с помощью ``cd ..``, или ``cd /var/www``
3. Обновляем версию composer до 2.x: ``composer self-update --2`` 
4. Запускаем команду ```composer create-project --prefer-dist yiisoft/yii2-app-basic basic```, на все отвечаем y и ждем
5. Далее перемещаем файлы в нашу папку html, чтобы она появилась в папк src хост машины: ``mv basic/* html``

Все, файлы установлены и в хост машине в папке src появились файлы фреймворка.

Из контейнера можно выйти, открыть браузер и ввести localhost. Если возникла ошибка с директориями, то можно выполнить следующие команды:
```
docker-compose exec php chown -R www-data:www-data /var/www/html/web/assets
docker-compose exec php chown -R www-data:www-data /var/www/html/runtime
docker-compose exec php chown -R www-data:www-data /var/www/html/runtime/cache
```

Тогда проблемы с правами на директории будут решены.

Первичная настройка yii2
---
1. Прописать в config/db.php реквизиты к базе данных, ``host=localhost`` заменить localhost на mariadb как написано в файле docker-compose.yaml
2. Раскомментировать в config/web.php секцию urlManager, чтобы запросы были без index.php
3. В config/web.php для модулей debug/gii, раскомментировать allowedIPs и указать звездочку для всех подключений
4. В config/web.php на первом уровне массива конфигурации добавить:
```
    'timeZone' => 'Europe/Moscow',
    'language' => 'ru',
```
5. Проверить, что база данных ок: войти в контейнер php, в нем выполнить команду: ``php yii migrate``