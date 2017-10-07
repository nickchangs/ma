#!/bin/bash
#echo "設定nginx.conf，把載入conf目錄從vhost切換成ma"
#sed -i 's/conf\/ma/conf\/vhost/g' /opt/APP/openresty/nginx/conf/nginx.conf
echo "設定vhost conf，把MAM改成0"
sed -i 's/^\s*set $MAM 1/\    set $MAM 0/g' /opt/APP/openresty/nginx/conf/vhost/*.conf
if [ $? = 0 ]; then
    #echo "切換ma目錄成功"
    echo "修改變數MAM成功"
else
    #echo "切換ma目錄失敗"
    echo "修改變數MAM失敗"
fi
echo "判斷ma.html路徑"
if [ ! -d "/opt/Htdocs/service" ]; then
    echo "舊版在/opt/Htdocs/ma"
    filepathe="/opt/Htdocs/ma/maintain.html"
    filepatha="/opt/Htdocs/ma/wap_maintain.html"
else
    echo "新版在/opt/Htdocs/service"
    filepathe="/opt/Htdocs/service/maintain.html"
    filepatha="/opt/Htdocs/service/wap_maintain.html"
fi
echo "把維護時間從maintain.html內清除"
sed -i '/维护時間/d' $filepathe
if [ $? = 0 ]; then
    echo "maintain.html清除維護時間成功"
else
    echo "maintain.html清除維護時間失敗"
fi
echo "把維護時間從wap_maintain.html內清除"
sed -i '/维护時間/d' $filepatha
if [ $? = 0 ]; then
    echo "wap_maintain.html清除維護時間成功"
else
    echo "wap_maintain.html清除維護時間失敗"
fi
systemctl reload nginx
if [ $? = 0 ]; then
echo "nginx重載設定檔成功"
else
echo "nginx重載設定檔失敗"
fi
