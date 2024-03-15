echo -n "Enter ip address: "
read ip
echo -n "port: "
read port
sed -i "s/.*Endpoint.*/Endpoint = $ip:$port/" ./full_user_config_generate.sh
#
