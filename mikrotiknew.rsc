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
