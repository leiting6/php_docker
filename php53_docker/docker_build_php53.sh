#!/usr/bin/env bash
docker run -it \
--name php53-web1 \
-h php53-web1 \
--env-file ./lnc.list \
--privileged=true \
--cap-add SYS_PTRACE \
--restart=always \
-e TZ=Asia/Shanghai \
-v /opt/data:/opt/data \
-v /opt/data/php53log:/usr/local/php-5.3.10/var/log \
-d  \
-p 10900:9000 \
php-53/prd:v2.0 \
sh /root/init.sh
