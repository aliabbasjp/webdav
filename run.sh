#!/bin/bash

# make sure webdav folder perms are right
chown www-data:root /srv/webdav
chown www-data /var/lock/apache2

# insert webdav apache conf
if [ -f "webdav.conf" ]; then
    sed -i /etc/apache2/sites-enabled/default-ssl.conf -e '/CustomLog.*/r webdav.conf'
    rm webdav.conf
fi

# generate a new key and cert
if [ -n "$GENERATE_CERT" ]; then
    openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 \
        -subj "/C=$GENERATE_CERT_C/ST=$GENERATE_CERT_ST/L=$GENERATE_CERT_L/O=$GENERATE_CERT_O/CN=$GENERATE_CERT_CN" \
        -keyout /etc/ssl/private/ssl-cert-snakeoil.key \
        -out /etc/ssl/certs/ssl-cert-snakeoil.pem
fi

# set a password and permissions on the file
if [ ! -f "/etc/apache2/webdav.password" ]; then
    htpasswd -cb /etc/apache2/webdav.password $USERNAME $PASSWORD
    chown root:www-data /etc/apache2/webdav.password
    chmod 640 /etc/apache2/webdav.password
fi

# start apache
exec apache2 -D FOREGROUND
