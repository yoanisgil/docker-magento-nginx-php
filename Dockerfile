FROM nginx:1.9.6

MAINTAINER Sylvain Witmeyer <sylvain@mapleinside.com>

RUN apt-get -qqy update \
 && apt-get -qqy install supervisor \
                         php5-fpm \
                         php5-curl \
                         php5-gd \
                         php5-mcrypt \
                         php5-mysql \
                         php5-redis \
                         php5-xsl \
 && apt-get autoremove -y && \
    apt-get clean && \
    apt-get autoclean && \
    echo -n > /var/lib/apt/extended_states && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/man/?? && \
    rm -rf /usr/share/man/??_*

COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY ./php-fpm/php-fpm.conf /etc/php5/fpm/php-fpm.conf
COPY ./php-fpm/www-pool.conf /etc/php5/fpm/pool.d/www.conf
COPY ./supervisord.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord", "-n" , "-c", "/etc/supervisord.conf"]
