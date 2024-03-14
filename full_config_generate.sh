#!/bin/bash
echo -n "Enter_client_name: "
read usern
private=-private.key
public=-public.key
# Get a string of ip addresses from the file /etc/wireguard/wg0.conf
a="$(grep -E -o "[1][0][\.][0][\.][0][\.][0-9]{1,3}" /etc/wireguard/wg0.conf)"
# Flip the line and extract the last digit of the ip address
b="$(echo $a |rev |cut -d "." -f1 |rev)"
# If the number is less than 255, then increase the value by one
if (("$b" < "255"))
then
let b++
ipa=10.0.0.$b/32


mkdir /etc/wireguard/client_cert/$usern
wg genkey | tee /etc/wireguard/client_cert/$usern/$usern$private | wg pubkey > /etc/wireguard/client_cert/$usern/$usern$public

touch /etc/wireguard/client_conf/$usern.conf

privatekeyuser=$(cat /etc/wireguard/client_cert/$usern/$usern$private)
echo -n '[Interface]
PrivateKey = ' >> /etc/wireguard/client_conf/$usern.conf
echo $privatekeyuser >> /etc/wireguard/client_conf/$usern.conf

echo -n 'Address = ' >> /etc/wireguard/client_conf/$usern.conf
echo -n $ipa >> /etc/wireguard/client_conf/$usern.conf
echo '
DNS = 8.8.8.8
[Peer]
PublicKey = iFBZYqSUwed2vr8esL+1iBXgk8k1b9qizROBOK79sRA=
Endpoint =
AllowedIPs = 0.0.0.0/0
PersistentKeepalive = 25' >> /etc/wireguard/client_conf/$usern.conf
######################################
# Write to the configuration file wg0#
######################################
echo "#" >> /etc/wireguard/wg0.conf
echo -n '#' >> /etc/wireguard/wg0.conf
echo $usern >> /etc/wireguard/wg0.conf
publicuserkey=$(cat /etc/wireguard/client_cert/$usern/$usern$public)
echo -n '[Peer]
PublicKey = ' >> /etc/wireguard/wg0.conf
echo  $publicuserkey >> /etc/wireguard/wg0.conf

echo -n 'AllowedIPs =' >> /etc/wireguard/wg0.conf
echo  $ipa >> /etc/wireguard/wg0.conf


systemctl reload wg-quick@wg0.service
else echo "The IP addresses have run out"
fi
