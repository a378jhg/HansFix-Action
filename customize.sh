#!/system/bin/sh
SKIPUNZIP=0
ui_print "- 正在安装 HansFix 模块"
set_perm_recursive $MODPATH 0 0 0755 0644
set_perm $MODPATH/service.sh 0 0 0755
