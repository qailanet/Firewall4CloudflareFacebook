#!/bin/sh
exec > /var/log/cloudflare.log 2>&1
set -x
for ip in $(curl -s https://www.cloudflare.com/ips-v4); do /usr/sbin/iptables -I INPUT -p tcp -m multiport --dports http,https -s "$ip" -j ACCEPT; done
for ip in $(curl -s https://www.cloudflare.com/ips-v6); do /usr/sbin/ip6tables -I INPUT -p tcp -m multiport --dports http,https -s "$ip" -j ACCEPT; done
