!#/bin/bash
geoipdata=`grep GeoIP.dat /opt/APP/openresty/nginx/conf/nginx.conf | awk '{print $2}' | sed -r 's/;//g'`
wget -O $geoipdata $1
