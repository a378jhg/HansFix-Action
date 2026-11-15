#!/system/bin/sh
MODDIR=${0%/*}
until [ "$(getprop sys.boot_completed)" = "1" ]; do sleep 2; done
sleep 10
MAP_PATH="/sys/fs/bpf/map_oplus-netd_app_hans_limit_map"
while true; do
  if [ -e "$MAP_PATH" ]; then
    KEYS=$(bpftool map dump pinned "$MAP_PATH" 2>/dev/null | grep "key:" | awk '{print $2, $3, $4, $5}')
    if [ -n "$KEYS" ]; then
      echo "$KEYS" | while read -r k1 k2 k3 k4; do
        bpftool map delete pinned "$MAP_PATH" key hex $k1 $k2 $k3 $k4 2>/dev/null
      done
      echo "$(date): 已静默解除网络限制" >> /data/local/tmp/hans_fix.log
    fi
  fi
  sleep 1
done
