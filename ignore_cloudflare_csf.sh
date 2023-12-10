for i in `curl https://www.cloudflare.com/ips-v4`; do echo $i >> /etc/csf/csf.ignore; done
