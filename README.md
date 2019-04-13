# JFLYBOOK
Deploy your **Jupyter Notebook** on any server to be used by any device anywhere.

# Requirement
* docker >= 1.13.0
* you have server and registered domain

# Installation
Add your python lib you want to use by modifying **requirements.txt** file

```sh
# file requirements.txt

# Jupyter metapackage. Install all the Jupyter components in one go.
jupyter==1.0.0

# NumPy is the fundamental package for array computing
numpy==1.16.2

# add more package bellow
```

copy default pre-configured file

```sh
$ cp docker-compose.yml.example docker-compose.yml
$ cp .env.example .env
```

Pull image and build
```sh
$ docker-compose build jflybook
$ docker-compose pull nginx
```

Setting up Password your jupyter nootebook password

```sh
$ docker-compose run --rm jflybook sh -c 'jupyter notebook --generate-config -y && jupyter notebook password'
```

## Add your Domain
modify .env file  and change to your own domain.

```sh
DOMAIN_HOST=yourdomain.com # change yourdomain.com
```

run it
```
docker-compose up -d
```

open it and login using your own domain.

your notebook file ***.ipynb** will be inside **notebook** directory.

# SSL Let's encrypt
adding ssl is easy, just modify **conf.d/default.conf** file and **docker-compose.yml** file to mount your letsencrypt SSL.


mount /etc/letsencrypt folder in docker-compose.yml nginx services

```docker
# file docker-compose.yml

services:
  nginx:
    volumes:
      - ./conf.d:/etc/nginx/conf.d
      - /etc/letsencrypt:etc/letsencrypt
```


modify **conf.d/default.conf** to point to your SSL file
```sh
# conf.d/default.conf
# listen 80; change this line
listen 443 ssl;

ssl_certificate /etc/letsencrypt/live/yourdomain.com/fullchain.pem;
ssl_certificate_key /etc/letsencrypt/live/yourdomain.com/privkey.pem;
```