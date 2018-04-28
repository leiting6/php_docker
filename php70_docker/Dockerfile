FROM centos:latest
MAINTAINER "leiting.liu@lexisnexis.com leiting.liu@qq.com"

ENV TZ=Asia/Hong_Kong
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN yum install -y \
tar.x86_64 \
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

RUN useradd --create-home -s /bin/bash -u 502 www

COPY php70/php-7.0.28.tar.gz /opt/
RUN cd /opt && tar zxf php-7.0.28.tar.gz
RUN cd /opt/php-7.0.28 && ./configure --prefix=/usr/local/php-7.0.28 --exec-prefix=/usr/local/php-7.0.28 --bindir=/usr/local/php-7.0.28/bin --sbindir=/usr/local/php-7.0.28/sbin --includedir=/usr/local/php-7.0.28/include --mandir=/usr/local/php-7.0.28/php/man --with-config-file-path=/usr/local/php-7.0.28/etc --with-mysql-sock --with-mcrypt --with-mhash --with-openssl --with-mysqli=shared,mysqlnd --with-pdo-mysql=shared,mysqlnd --with-gd --with-iconv --with-zlib --enable-zip --enable-inline-optimization --disable-debug --disable-rpath --enable-shared --enable-xml --enable-bcmath --enable-shmop --enable-sysvsem --enable-mbregex --enable-mbstring --enable-ftp --enable-gd-native-ttf --enable-pcntl --enable-sockets --with-xmlrpc --enable-soap --with-gettext --enable-session --with-curl --with-jpeg-dir --with-freetype-dir --enable-opcache --enable-fpm --with-fpm-user=www --with-fpm-group=www --without-gdbm --with-libdir=lib64 
RUN cd /opt/php-7.0.28 && make && make install

RUN mv /usr/local/php-7.0.28/bin/php /usr/local/php-7.0.28/bin/php70 && mv /usr/local/php-7.0.28/sbin/php-fpm /usr/local/php-7.0.28/sbin/php-fpm-70
RUN ln -s /usr/local/php-7.0.28/bin/php70 /usr/local/php-7.0.28/bin/php
RUN ln -s /usr/local/php-7.0.28/sbin/php-fpm-70 /usr/local/php-7.0.28/sbin/php-fpm
ENV PATH=$PATH:/usr/local/php-7.0.28/bin/:/usr/local/php-7.0.28/sbin/

ADD php70/php-fpm.conf /usr/local/php-7.0.28/etc/
ADD php70/php.ini /usr/local/php-7.0.28/etc/
ADD php70/php-fpm.d/www.conf /usr/local/php-7.0.28/etc/php-fpm.d/

COPY php70/pecl-memcache-NON_BLOCKING_IO_php7.tar.gz /opt/
RUN cd /opt && tar zxf pecl-memcache-NON_BLOCKING_IO_php7.tar.gz
RUN cd /opt/pecl-memcache-NON_BLOCKING_IO_php7 && ./configure --with-php-config=/usr/local/php-7.0.28/bin/php-config && make && make install

RUN cd /tmp && curl -sS https://getcomposer.org/installer | php
RUN mv /tmp/composer.phar /usr/local/bin/composer

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
