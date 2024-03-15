**Wireguard full user config generate**

This project is a script for automatically creating a Wireguard user configuration file

The script automatically generates the user's public and private keys, creates a user configuration file, and writes the values of the server and client IP addresses to the client and server file configuration. 

Subnet for the clients: 10.0.0.0/24


**Prepare**

You must have:
- The wireguard server installed
- The /etc/wireguard.conf configuration file configured
- Public and  server keys generated:  /etc/wireguard/wg-private.key  and /etc/wireguard/wg-public.key
- Directories have been created: /etc/wireguard/client_cert and /etc/wireguard/client_conf

You can use the file prepare.sh to specify the ip address and port of the Wireguard server, or specify these values manually in the file full_congig_generate.sh .
