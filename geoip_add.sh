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
if [ $1 == add ]; then
	sed -i '/^\s*default\ 1/a\          '$2'/32\ 0;' /opt/APP/openresty/nginx/conf/nginx.conf
if [ $? = 0 ]; then
    echo "新增geoip白名單成功"
else
    echo "新增geoip白名單失敗"
    exit
fi
fi
#刪除geoip
if [ $1 == del ]; then
        sed -i '/^\s*'$2'\/32\ 0\;/d' /opt/APP/openresty/nginx/conf/nginx.conf
if [ $? = 0 ]; then
    echo "刪除geoip白名單成功"
else
    echo "刪除geoip白名單失敗"
    exit
fi
fi
#顯示geoip清單
if [ $1 == show ]; then
        grep '^\s*[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' /opt/APP/openresty/nginx/conf/nginx.conf
if [ $? = 0 ]; then
    echo "顯示geoip白名單成功"
else
    echo "顯示geoip白名單失敗"
    exit
fi
fi
#if [ $? = 0 ]; then
#    echo "新增geoip白名單成功"
#else
#    echo "新增geoip白名單失敗"
#    exit
#fi
#重啟nginx服務
#service nginx restart
#if [ $? = 0 ]; then
#    echo "重新啟動nginx設定檔成功"
#else
#    echo "重啟nginx失敗，請使用nginx -t查詢正確認"
#    exit
#fi