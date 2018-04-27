# php53_docker

1,开启php-fpm的慢日志后，需要同时打开如下2个选项：

slowlog的日志路径请手动补充添加var/目录，否则会报错

slowlog = var/log/$pool.log.slow

request_slowlog_timeout = 30
