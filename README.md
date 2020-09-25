# pi-lamp-docker
A docker-compose for a Pi-friendly (armv7) LAMP Stack.

## Stack

- Apache
- PHP
- MariaDB
- phpMyAdmin

## Dependencies

```
docker
docker-compose
```

## Based on these LAMP containers

- https://hub.docker.com/_/php
- https://hub.docker.com/r/linuxserver/mariadb
- https://hub.docker.com/_/phpmyadmin

##  Installation

```shell
git clone https://github.com/DragonFlayer/pi-lamp-docker.git
cd pi-lamp-docker/
//change the docker-compose.yml file according to your configuration before starting
docker-compose up -d
```

## Configuration

Modify the docker-compose.yml file and focus on the following.

### Passwords

- `MYSQL_ROOT_PASSWORD: dbrootpassword` is the password for your MariaDB's root user, please change it on both `db:` and `db_pma:` sections.
- `PMA_USER: root` is your phpMyAdmin username.
- `PMA_PASSWORD: pmapassword` is your phpMyAdmin password.

### Ports

- Apache will publish to ports `80:80` and `443:443`.
- MariaDB will publish to port `3306:3306`.
- phpMyAdmin will publish to port `8088:80`.

Change these ports according to your needs.

## Volumes

- `./html` will store your web application.
- `./db` will store your database setup.
