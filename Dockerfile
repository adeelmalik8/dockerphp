# FROM php:7.2-apache
# COPY ./ /var/www/html/
# Specify a base image
# FROM alpine
# RUN apk update 
# RUN apk upgrade && DEBIAN_FRONTEND=noninteractive 
# RUN apk add apache2
# RUN apk add openrc --no-cache
# # RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
#  RUN service apache2 start
# #  RUN service apache2 restart

# EXPOSE 80
FROM ubuntu:latest
RUN apt-get update  \ 
    &&  apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive \
    apt-get -y install \
    apache2 \
    apache2-utils \
    php php-mysql \
    libapache2-mod-php \
    curl nano/*
RUN service apache2 start
WORKDIR /var/www/html

ENV APACHE_RUN_USER www-data
COPY ./ ./
RUN chmod 777 /var/log \
   && chmod 777 /var/run \
   && chmod 777 /var/www/html \
   && chmod 777 /var/lock 

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
