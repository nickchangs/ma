#!/bin/bash
#/opt/APP/openresty/nginx/conf/nginx.conf檔案是否存在
filepathe="/opt/APP/openresty/nginx/conf/nginx.conf"
if [ -e $filepathe ];then
    echo "nginx.conf存在，將繼續執行"
else
    echo "nginx.conf不存在！請確認維謢網頁是否存在"
    exit
fi
#新增geoip
sed -i '/^\s*default\ 1/a\          '$1'/32\ 0;' /opt/APP/openresty/nginx/conf/nginx.conf
if [ $? = 0 ]; then
    echo "新增geoip白名單成功"
else
    echo "新增geoip白名單失數"
    exit
fi
#重啟nginx服務
service nginx restart
if [ $? = 0 ]; then
    echo "重新啟動nginx設定檔成功"
else
    echo "重啟nginx失敗，請使用nginx -t查詢正確認"
    exit
fi
