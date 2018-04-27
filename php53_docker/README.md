# php53_docker

1，开启php-fpm的慢日志，需要同时打开如下2个选项：

slowlog的日志路径请手动补充添加var/目录，否则会报错

slowlog = var/log/$pool.log.slow

request_slowlog_timeout = 30

2，php读取环境变量值

docker容器里貌似是不支持自动加载系统的环境变量的，所以，可以在运行容器时添加--env-file ./lnc.list的方式定义变量。把所有环境变量的值定义在lnc.list中。

3，php-fpm.conf配置

[global]

pid = run/php-fpm.pid

error_log = log/php-fpm.log

log_level = error

emergency_restart_threshold = 10

emergency_restart_interval = 1m

process_control_timeout = 5s
 
 
[www]

user = www

group = www

listen = 0.0.0.0:9000

 
pm = static

pm.max_children = 64

pm.start_servers = 30

pm.min_spare_servers = 20

pm.max_spare_servers = 35
 
slowlog = var/log/slow.log
 
request_slowlog_timeout = 30s
 
rlimit_files = 65535
 
catch_workers_output = yes
