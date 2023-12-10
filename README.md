# This simple script how to whitelist clouflare ip and facebook


## Configuration
Simply fetch data from cloudflare ip list

## Cloudflare ipv4 fetch and whitelist (IPTABLES)
```
for i in `curl https://www.cloudflare.com/ips-v4`; do iptables -I INPUT -p tcp -m multiport --dports http,https -s $i -j ACCEPT; done
```

## Cloudflare ipv6 fetch and whitelist (IPTABLES)
```
for i in `curl https://www.cloudflare.com/ips-v6`; do ip6tables -I INPUT -p tcp -m multiport --dports http,https -s $i -j ACCEPT; done
```

### CAUTION: If you get attacked and CloudFlare drops you, your site(s) will be unreachable. 
```
iptables -A INPUT -p tcp -m multiport --dports http,https -j DROP
ip6tables -A INPUT -p tcp -m multiport --dports http,https -j DROP
```

## Cloudflare ipv4 fetch and whitelist with CSF

```
for i in `curl https://www.cloudflare.com/ips-v4`; do csf -a $i; done
```

## Cloudflare ipv4 fetch and ignore with CSF
```
for i in `curl https://www.cloudflare.com/ips-v4`; do echo $i >> /etc/csf/csf.ignore; done
```

# The Facebook Crawler 
The Facebook Crawler crawls the HTML of an app or website that was shared on Facebook via copying and pasting the link or by a Facebook social plugin. The crawler gathers, caches, and displays information about the app or website such as its title, description, and thumbnail image.

## Crawler Requirements

* Your server must use gzip and deflate encodings.
* Any Open Graph properties need to be listed before the first 1 MB of your website or app, or it will be cutoff.
* Ensure that the content can be crawled by the crawler within a few seconds or Facebook will be unable to display the content.
* Your app or website should either generate and return a response with all required properties according to the bytes specified in the Range header of the crawler request or it should ignore the Range header altogether.
* Add to your allow list either the user agent strings or the IP addresses (more secure) used by the crawler.
* Ensure that your app or website allows the Facebook Crawler to crawl the privacy policy associated with your app or website.

## Crawler IPs and User Agents
The Facebook crawler user agent strings:
** facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)
** facebookexternalhit/1.1

To get a current list of IP addresses the crawler uses, run the following command.
```
whois -h whois.radb.net -- '-i origin AS32934' | grep ^route  
```

These IP addresses change often.
### Example Response

```
route:      69.63.176.0/21
route:      69.63.184.0/21
route:      66.220.144.0/20
route:      69.63.176.0/20
route6:     2620:0:1c00::/40
route6:     2a03:2880::/32
route6:     2a03:2880:fffe::/48
route6:     2a03:2880:ffff::/48
route6:     2620:0:1cff::/48
```

## Troubleshooting
If your app or website content is not available at the time of crawling, you can force a crawl once it becomes available either by passing the URL through the Sharing Debugger tool or by using the Sharing API.

You can simulate a crawler request with the following code:
```
curl -v --compressed -H "Range: bytes=0-524288" -H "Connection: close" -A "facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)" "$URL"
```
