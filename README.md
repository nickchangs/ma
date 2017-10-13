##快速切換app維護模式sop:

    1.	SSH登入splunk 172.16.100.96  user:root  pw:xxxxxx
    2.	執行 salt "*app*" test.ping 以確認所有app是否連線正常  
    3.	執行上面執行如果是有 Minion did not return. [Not connected]，請再執行一次salt "*app*" test.ping ，一定要所有回應為true為正常連線，如果測試一直有not connected，請restart salt-master 服務，再試一次  
    4.	確認所有連線皆為True，執行salt "*app*" cmd.run "sh /root/ma_app_start.sh 09:00 16:00" > APP_log_ma_start.txt  
    5.	確認APP_log_ma_start.txt是否有執行失敗的訊息，如果執行失敗的反代請用手動切換  
    6.	切回時，請一樣先使用salt "*app*" test.ping 確認所有連線是否正常  
    7.	檢查完成確認連線為true，執行salt "*app*" cmd.run "sh /root/ma_app_stop" > APP_log_ma_stop.txt  
    8.	確認APP_log_ma_stop.txt是否有執行失敗的訊息，如果執行失敗的反代請用手動切換  
    
手動方式：
    
    $1.  啟動維謢模式請編輯 vi /opt/APP/openresty/nginx/conf/nginx.conf 將#include /opt/APP/openresty/nginx/conf/ma/ma.conf 註解拿掉，且將include /opt/APP/openresty/nginx/conf/vhost/*.conf 註解  
    $2.  Service nginx reload  
    $3.  關閉維謢模式則反過來，將*.conf移除註解，並將ma.conf註解，後再重新load nginx  
    
快速切換前台維護模式sop:

    1.	SSH登入splunk 172.16.100.96  user:root  pw:xxxxx  
    2.	執行 salt "*fe*" test.ping 以確認所有fe是否連線正常  
    3.	執行上面執行如果是有 Minion did not return. [Not connected]，請再執行一次salt "*fe*" test.ping ，一定要所有回應為true為正常連線，如果測試一直有not connected，請restart salt-master 服務，再試一次  
    4.	確認所有連線皆為True，執行salt "*fe*" cmd.run "sh /root/ma_fe_start.sh 09:00 16:00" > FE_log_ma_start.txt  
    5.	確認FE_log_ma_start.txt是否有執行失敗的訊息，如果執行失敗的反代請用手動切換  
    6.	切回時，請一樣先使用salt "*fe*" test.ping 確認所有連線是否正常  
    7.	檢查完成確認連線為true，執行salt "*fe*" cmd.run "sh /root/ma_fe_stop" > FE_log_ma_stop.txt  
    8.	確認FE_log_ma_stop.txt是否有執行失敗的訊息，如果執行失敗的反代請用手動切換  
    
手動方式：

    啟動維謢模式請編輯 vi /opt/APP/openresty/nginx/conf/vhost/*.conf，將http&https conf檔內的MAM由0改為1，後重新load nginx服務  
    關閉時請編輯 vi /opt/APP/openresty/nginx/conf/vhost/*.conf，將http&https conf檔內的MAM由1改為0，後重新load nginx服務
