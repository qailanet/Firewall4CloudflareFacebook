for i in `curl https://www.cloudflare.com/ips-v4`; do csf -a $i; done
