#!/usr/bin/env bash
docker run -it \
--name php70-web2 \
-h php70-web2 \
--env-file ./lnc.list \
--privileged=true \
--cap-add SYS_PTRACE \
--restart=always \
-e TZ=Asia/Hong_Kong \
-v /opt/data:/opt/data \
-v /opt/data/php70log:/usr/local/php-5.3.10/var/log \
-d  \
-p 20900:9000 \
php-70/prd:v2.0 \
sh /root/init.sh

