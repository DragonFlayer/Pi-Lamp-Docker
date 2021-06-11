# Pi Lamp Docker
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

## Based on these containers

- https://hub.docker.com/_/php
- https://hub.docker.com/r/linuxserver/mariadb
- https://hub.docker.com/_/phpmyadmin
- https://hub.docker.com/r/goacme/lego/

##  Installation

```shell
git clone https://github.com/DragonFlayer/pi-lamp-docker.git
cd pi-lamp-docker/
mv example.env .env
//modify .env
//modify docker-compose.yml file according to your configuration before starting
mkdir apache
mkdir php
docker-compose up -d
```

## Configuration

Modify the docker-compose.yml file and focus on the following.

### ENV

You will need to create a .env file based on example.env for the work directory variable used in the docker-compose file, as well as for future use of the lego.sh file for certificate acquisition.

```
mv example.env .env
nano .env
```

- `WORKDIR` set this to your work directory.
- `DOCKER_ARGS` arguments for the lego script's docker run.
- `DOCKER_VOL` volume for the lego script's docker run, default is `/cert:/.lego`
- `DOCKER_ENV` environment variables for the lego script's docker run.
- `LEGO_ARGS` arguments for the lego script's command.
- `LEGO_DOMAINS` the domain you want a certificate for.
- `LEGO_EMAIL` the admin's email.
- `LEGO_LOG` log file, default is `/lego.log`

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

- `/html` will store your web application.
- `/db` will store your database setup.
- `/apache` will store your apache configuration.
- `/php` will store your php configuration.
- `/cert` will store your certificates after using the lego script.

## SSL

You must modify .env for your intended purpose, be it acquiring or renewing your certificates and pass your main argument to lego.sh (run, renew, etc)

Example for acquiring a certificate

.env
```
WORKDIR=/your/work/directory
DOCKER_ARGS=--rm
DOCKER_VOL=/cert:/.lego
DOCKER_ENV=DYNU_API_KEY=SomeDynuDNSAPIKey
LEGO_ARGS=--dns dynu --accept-tos
LEGO_DOMAINS=www.example.org
LEGO_EMAIL=example@example.com
LEGO_LOG=/lego.log
```

CLI
```
./lego.sh run
```

Example for renewing a certificate

.env
```
WORKDIR=/your/work/directory
DOCKER_ARGS=--rm
DOCKER_VOL=/cert:/.lego
DOCKER_ENV=DYNU_API_KEY=SomeDynuDNSAPIKey
LEGO_ARGS=--dns dynu
LEGO_DOMAINS=www.example.org
LEGO_EMAIL=example@example.com
LEGO_LOG=/lego.log
```

CLI
```
./lego.sh renew
```

Use Lego's Usage reference for arguments you can use for the LEGO variables and what type of challenges and DNS providers are supported by it.
- https://go-acme.github.io/lego/usage/cli/


All certificate data will be saved to your DOCKER_VOL mapping, by default `/cert`, if you use that directory to setup your apache ssl configuration, you can use a cron job to automate renewal as such:

```
sudo crontab -e
//add the following line to the end of your crontab
0 0 * * * bash /your/work/directory/lego.sh renew
```

This would attempt a renewal every day at midnight, by default, lego only renews certificates with less than 30 days before expiration, modify the cron job's time rate to fit your needs, also consider using the argument --days for lego if 30 days is not satisfactory.
