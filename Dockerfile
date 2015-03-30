FROM debian:wheezy
MAINTAINER Shay Erlichmen <shay@samba.me>

# Install Nginx
RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
RUN echo "deb http://nginx.org/packages/debian/ wheezy nginx" >> /etc/apt/sources.list

ENV NGINX_VERSION 1.6.2-1~wheezy

RUN apt-get update && apt-get install -y nginx=${NGINX_VERSION} && apt-get clean autoclean

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

RUN which nginx; nginx -V

CMD ["nginx", "-g", "daemon off;"]
