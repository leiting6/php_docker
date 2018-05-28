FROM centos:6.9
MAINTAINER "leiting.liu@lexisnexis.com leiting.liu@qq.com"

ENV TZ=Asia/Hong_Kong
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN yum install -y \
wget \
git \
vim \
unzip \
net-tools \
ntpdate \
ntp \
openssh-clients \
readline-devel \
libtidy \
libtidy-devel \
gcc \
gcc-c++ \
autoconf \
freetype \
freetype-devel \
libjpeg \
libjpeg-devel \
libpng \
libpng-devel \
libxml2 \
libxml2-devel \
zlib \
zlib-devel \
glibc \
glibc-devel \
glib2 \
glib2-devel \
bzip2 \
bzip2-devel \
ncurses \
curl \
libcurl-devel \
openssl-devel \
gdbm-devel \
db4-devel \
libXpm-devel \
libX11-devel \
libxslt-devel \
gd \
gd-devel \
gmp-devel \
expat-devel \
xmlrpc-c \
xmlrpc-c-devel \
libxml2* \
epel-release \
crontabs \
psmisc \
libicu-devel \
pcre-devel \
openldap \
openldap-devel \
ImageMagick-devel \
make

RUN yum -y install epel-release && yum install -y libmcrypt libmcrypt-devel mcrypt mhash

RUN cp /usr/lib64/libldap* /usr/lib/

RUN cd /opt && wget http://museum.php.net/php5/php-5.3.10.tar.gz
RUN cd /opt && tar zxf php-5.3.10.tar.gz
RUN cd /opt/php-5.3.10 && './configure' '--prefix=/usr/local/php-5.3.10' '--with-config-file-path=/usr/local/php-5.3.10/etc' '--with-mysql=mysqlnd' '--with-mysqli=mysqlnd' '--with-iconv-dir=/usr/local' '--with-freetype-dir' '--with-jpeg-dir' '--with-png-dir' '--with-zlib' '--with-libxml-dir' '--enable-xml' '--enable-safe-mode' '--enable-bcmath' '--enable-shmop' '--enable-sysvsem' '--enable-inline-optimization' '--with-curl' '--with-curlwrappers' '--enable-mbregex' '--enable-fpm' '--enable-mbstring' '--with-mcrypt' '--with-gd' '--enable-gd-native-ttf' '--with-openssl' '--with-mhash' '--enable-pcntl' '--enable-sockets' '--with-ldap' '--with-ldap-sasl' '--with-xmlrpc' '--enable-zip' '--enable-soap' '--enable-ftp' '--enable-pdo' '--with-mysql=mysqlnd' '--with-mysqli=mysqlnd' '--with-pdo-mysql=mysqlnd'
RUN cd /opt/php-5.3.10 && make && make install

RUN mv /usr/local/php-5.3.10/bin/php /usr/local/php-5.3.10/bin/php53 && mv /usr/local/php-5.3.10/sbin/php-fpm /usr/local/php-5.3.10/sbin/php-fpm-53
RUN ln -s /usr/local/php-5.3.10/bin/php53 /usr/local/php-5.3.10/bin/php
RUN ln -s /usr/local/php-5.3.10/sbin/php-fpm-53 /usr/local/php-5.3.10/sbin/php-fpm
ENV PATH=$PATH:/usr/local/php-5.3.10/bin/:/usr/local/php-5.3.10/sbin/

RUN useradd --create-home -s /bin/bash -u 60001 www

COPY php53/eaccelerator-0.9.6.1.tar.bz2 /opt/
RUN cd /opt/ && tar -jxf eaccelerator-0.9.6.1.tar.bz2
RUN cd /opt/eaccelerator-0.9.6.1 && /usr/local/php-5.3.10/bin/phpize
RUN cd /opt/eaccelerator-0.9.6.1 && ./configure --enable-eaccelerator=shared --with-php-config=/usr/local/php-5.3.10/bin/php-config && make && make install

COPY php53/imagick-3.0.1.tgz /opt/
RUN cd /opt/ && tar -zxf imagick-3.0.1.tgz
RUN cd /opt/imagick-3.0.1 && /usr/local/php-5.3.10/bin/phpize
RUN cd /opt/imagick-3.0.1 && ./configure --with-php-config=/usr/local/php-5.3.10/bin/php-config && make && make install

COPY php53/yaf-2.3.5.tgz /opt/
RUN cd /opt/ && tar -zxf yaf-2.3.5.tgz
RUN cd /opt/yaf-2.3.5 && /usr/local/php-5.3.10/bin/phpize
RUN cd /opt/yaf-2.3.5 && ./configure --with-php-config=/usr/local/php-5.3.10/bin/php-config && make && make install

COPY php53/phpextension.tar.gz /opt/
RUN cd /opt/ && tar -zxf phpextension.tar.gz
RUN cd /opt/phpextension.git/multi_http_get && /usr/local/php-5.3.10/bin/phpize
RUN cd /opt/phpextension.git/multi_http_get && ./configure --with-php-config=/usr/local/php-5.3.10/bin/php-config && make && make install

COPY php53/php-memcache_3.0.9~20160311.4991c2f.orig.tar.gz /opt/
RUN cd /opt/ && tar -zxf php-memcache_3.0.9~20160311.4991c2f.orig.tar.gz
RUN cd /opt/php-memcache-3.0.9~20160311.4991c2f/memcache-3.0.9 && /usr/local/php-5.3.10/bin/phpize
RUN cd /opt/php-memcache-3.0.9~20160311.4991c2f/memcache-3.0.9 && ./configure --with-php-config=/usr/local/php-5.3.10/bin/php-config && make && make install

#RUN mv /usr/local/php-5.3.10/etc/php-fpm.conf /usr/local/php-5.3.10/etc/php-fpm.conf.bak
#RUN mv /usr/local/php-5.3.10/etc/php.ini /usr/local/php-5.3.10/etc/php.ini.bak
ADD php53/php-fpm.conf /usr/local/php-5.3.10/etc/
ADD php53/php.ini /usr/local/php-5.3.10/etc/

RUN cd /tmp && curl -sS https://getcomposer.org/installer | php
RUN mv /tmp/composer.phar /usr/local/bin/composer

#COPY src/Python-2.7.13.tar.gz /opt
#RUN cd /opt && tar zxf Python-2.7.13.tar.gz
#RUN cd /opt/Python-2.7.13 && ./configure --prefix=/usr/local && make && make altinstall
#RUN ln -sf /usr/local/bin/python2.7 /usr/bin/python
#RUN sed -i 's/python/python2.6/g' /usr/bin/yum

#RUN cd /opt && wget https://bootstrap.pypa.io/get-pip.py
#RUN cd /opt && python get-pip.py
#RUN pip install supervisor

#RUN mkdir -p /etc/supervisor/conf.d
#ADD etc/supervisord.conf /etc/
#ADD etc/supervisor/ntpdate.ini /etc/supervisor/conf.d/
#ADD etc/supervisor/php-fpm.ini /etc/supervisor/conf.d/

ADD src/init.sh /root/

EXPOSE 9000
WORKDIR /home/www
