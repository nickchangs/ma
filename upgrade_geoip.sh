geoipdata=`grep GeoIP.dat /opt/APP/openresty/nginx/conf/nginx.conf | awk '{print $2}' | sed -r 's/;//g'`
wget -O $geoipdata https://raw.githubusercontent.com/nickchangs/ma/master/GeoIP-106_20171017.dat
