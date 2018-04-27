# php53_docker

1，开启php-fpm的慢日志，需要同时打开如下2个选项：

slowlog的日志路径请手动补充添加var/目录，否则会报错

slowlog = var/log/$pool.log.slow

request_slowlog_timeout = 30

2，php读取环境变量值

docker容器里貌似是不支持自动加载系统的环境变量的，所以，可以在运行容器时添加--env-file ./lnc.list的方式定义变量。把所有环境变量的值定义在lnc.list中。
