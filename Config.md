# Config

### Router

#### Generate Script
Login to the dashboard
__
http://185.56.88.234/wifi/
username Administrator
password Administrator __

From the menu, select wizard,  and follow the steps.
Finally, from the router, you can see "configuration".


Adding VPN User we created by the Wizard on the server .
```
echo "user  pptpd   password    10.0.0.19 # RouterId 18" >> /etc/ppp/chap-secrets && /etc/init.d/pptpd restart
```

### Example :
Location :  /var/www/html/wifi/Engine/Routers.class.php

```
/interface bridge
add name=bridge-local
/interface ethernet
set [ find default-name=ether1 ] name=ether1-gateway
set [ find default-name=ether2 ] name=ether2-master-local
set [ find default-name=ether3 ] master-port=ether2-master-local name=ether3-slave-local
set [ find default-name=ether4 ] master-port=ether2-master-local name=ether4-slave-local
set [ find default-name=ether5 ] master-port=ether2-master-local name=ether5-slave-local
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-b/g/n channel-width=20/40mhz-ht-above disabled=no distance=indoors l2mtu=2290 mode=ap-bridge ssid=Buca wireless-protocol=802.11
/ip neighbor discovery
set ether1-gateway discover=no
/ip pool
add name=default-dhcp ranges=10.0.22.2-10.0.22.254
/ip dhcp-server
add add-arp=yes address-pool=default-dhcp disabled=no interface=bridge-local name=default
/interface pptp-client
add add-default-route=no allow=pap,chap,mschap1,mschap2 connect-to=185.56.88.234 dial-on-demand=no disabled=no keepalive-timeout=60 max-mru=1400 max-mtu=1400 mrru=disabled name=pptp-out1 password=C4N2pK2Ws7 profile=default-encryption user=Dvev2npHSp
/interface bridge port
add bridge=bridge-local interface=ether2-master-local
add bridge=bridge-local interface=wlan1
/ip address
add address=10.0.22.1/24 interface=bridge-local network=10.0.22.0
/ip dhcp-client
add default-route-distance=0 dhcp-options=hostname,clientid disabled=no interface=ether1-gateway
/ip dhcp-server network
add address=10.0.22.0/24 dns-server=8.8.8.8 gateway=10.0.22.1 netmask=24
/ip firewall mangle
add action=mark-routing chain=prerouting in-interface=bridge-local new-routing-mark=LAN_CLIENTS
/ip route
add distance=1 gateway=10.0.0.1 routing-mark=LAN_CLIENTS
```
### Server Config

#### Url Locations : 
* File that generate the router config is located under
 ```
/var/www/html/wifi/Engine/Routers.class.php
```
* The api does not require any changes, it's located under
```
/var/www/html/publicapi ```

* Main Hotspot page is located under
```
/var/www/html/wifi/PlanModules
```

* Script for the ip tables is located under
```
/etc/init.d/runpegasus
```
And locally [runpegasus](init.d/runpegasus.sh)

* traffic accounting
```
/etc/init.d/runtrafficaccounting
```
 [runtrafficaccounting](init.d/runtrafficaccounting.php)

*  Under /etc/ppp/ip-up.d

* Copy *

```
/etc/ppp/ip-up.d

```
[ip-up](/ip-up.d)

```
 /etc/ppp/ip-down.d
```
[ip-down.d](/ip-down.d)
* Install :
 - pptpd
 - apache2
 - ssl
 - conntrack
 -  whois

* add www-data user to the sudoers
```
sudo visudo 
   and add in the end; www-data ALL=NOPASSWD: /sbin/iptables
```
### Api Auth and example
#### Api :
SERVER_IP: 185.56.88.234
API_PATH: http://185.56.88.234/publicapi/index.php/
API_NAME: PegasusApi
API_VERSION: V1
API_KEY: UGVnYXN1cyBNYWRlIEJ5IEZhcmlkIE5ha2hsZQ==

#### Example URI:
 http://185.56.88.234/publicapi/index.php/UGVnYXN1cyBNYWRlIEJ5IEZhcmlkIE5ha2hsZQ==/Peg asusApi/V1/Denyip


#### PPTP Users on server
/etc/pptp/ => chap passwords 
