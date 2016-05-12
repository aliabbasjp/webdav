FROM ubuntu:14.04

RUN apt-get update \
  && apt-get -y install apache2 openssl apache2-utils \
  && apt-get autoremove -y \
  && apt-get clean \ 
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/

RUN a2enmod dav dav_fs ssl; a2ensite default-ssl

RUN mkdir -p /srv/webdav /var/lock/apache2 && chown www-data /srv/webdav /var/lock/apache2 && rm /var/www/html/index.html && touch /var/www/html/index.html

ENV APACHE_RUN_USER=www-data \
  APACHE_RUN_GROUP=www-data \
  APACHE_LOG_DIR=/var/log/apache2 \
  APACHE_PID_FILE=/var/run/apache2.pid \
  APACHE_LOCK_DIR=/var/lock/apache2 \
  APACHE_RUN_DIR=/var/run/apache2

EXPOSE 443
VOLUME ["/srv/webdav"]

COPY run.sh /

COPY webdav.conf /

CMD ["/run.sh"]
