ssh $1 << EOF
echo "=================================================================="
echo "=================================================================="
echo "======================update && upgrade==========================="
echo "=================================================================="
echo "=================================================================="

apt update && apt upgrade

echo "=================================================================="
echo "=================================================================="
echo "=======================deploy openresty==========================="
echo "=================================================================="
echo "=================================================================="

apt-get install -y libpcre3-dev  libssl-dev perl make build-essential curl  zlib1g-dev/stable  libpcre2-dev/stable
wget https://openresty.org/download/openresty-1.13.6.2.tar.gz
tar zxvf openresty-1.13.6.2.tar.gz
cd openresty-1.13.6.2/
./configure --with-http_realip_module --prefix=/usr/local/openresty  --with-pcre-jit --with-ipv6   --with-http_ssl_module --with-http_stub_status_module
make && make install

echo "=================================================================="
echo "=================================================================="
echo "=======================deploy php(php-fpm)========================"
echo "=================================================================="
echo "=================================================================="

apt install -y php7.0 php7.0-gd php7.0-xml php7.0-curl php7.0-mbstring php7.0-mcrypt php7.0-xmlrpc php7.0-common php7.0-readline php7.0-fpm php7.0-opcache php7.0-json
apt install -y  apt-transport-https lsb-release ca-certificates wget


echo "=================================================================="
echo "=================================================================="
echo "=======================deploy mariadb============================="
echo "=================================================================="
echo "=================================================================="
apt install -y  mariadb-server mariadb-client php7.0-mysql

EOF

scp nginx.conf $1:/usr/local/openresty/nginx/conf

ssh $1 << EOF
    /usr/local/openresty/bin/openresty    
EOF
