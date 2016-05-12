# Webdav Server in a Docker Container for x86 ubuntu

This image contains an Apache webserver configured to serve a webdav directory as `https://yourhost/webdav`. It is heavily influenced by the webdav images of [parente](https://hub.docker.com/r/parente/webdav/) and [morrisjobke](https://hub.docker.com/r/morrisjobke/webdav/).

You can use the following environment vars
 - USERNAME
 - PASSWORD
 - GENERATE_CERT
 - GENERATE_CERT_C
 - GENERATE_CERT_ST
 - GENERATE_CERT_L
 - GENERATE_CERT_O
 - GENERATE_CERT_CN

If you have your own cert, mount your key and crt file to `/etc/ssl/private/ssl-cert-snakeoil.key` and `/etc/ssl/certs/ssl-cert-snakeoil.pem`

Data resides at `/srv/webdav`

Exposed port is 443

Example: 
```
docker run -d -p "8443:443" -e PASSWORD=webdav_password -e USERNAME=webdav_user armhfbuild/webdav
```
