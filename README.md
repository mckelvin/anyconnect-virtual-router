# Anyconnect Virtual Router

## Features

- Anyconnect client as a router
- Customize routing table the way you like(chnroutes applied by default)

![](http://i.imgur.com/p2CVAMI.png?1)
![](http://i.imgur.com/jqsxNLi.png?1)


## Prerequisites

- Vagrant
- VirtualBox


## Usage

1. Check `bridge` in `Vagrantfile`, modify if necessary.
2. Start the virtual router via `vagrant up` .
3. `vagrant ssh` into the router.
4. Connect: `anyconnect connect your.anyconnect-server.com username password` (Modify parameters accordingly).
5. `ifconfig eth1` Use the IP address of `eth1` as your Gateway (you can also use the IP as your DNS server).
6. Disconnect: `anyconnect disconnect` (Remember to run this even when the tunnel is broken by accident).


## TODO

- sync `provisioning/etc/cn/apnic_cn_routes.tsv` with [chnroutes](https://github.com/fivesheep/chnroutes)
- sync `provisioning/etc/dnsmasq.d/*.conf` with [dnsmasq-china-list](https://github.com/felixonmars/dnsmasq-china-list)
- Web pages for admin


## LICENSE

Copyleft (c) 2015, GreatFireHole All rights revoked.
