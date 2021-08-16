# acme-dns-certbot

An example [Certbot](https://certbot.eff.org) client hook for [`acme-dns`](https://github.com/joohoi/acme-dns). 

This authentication hook automatically registers `acme-dns` accounts and prompts the user to manually add the CNAME records to their main DNS zone on initial run. Subsequent automatic renewals by Certbot cron job / systemd timer run in the background non-interactively.

Requires `certbot>=0.10`, `python3-requests` library.

## Installation

1. Install Certbot using instructions at [https://certbot.eff.org](https://certbot.eff.org) and install the [python-requests](http://docs.python-requests.org/en/master/) library.

1. Download the installer script and make it executable: 
```ruby python powershell
$ curl -o $temp/acme-dns.sh https://raw.githubusercontent.com/wackyblackie/acme-dns-certbot/master/install.sh; chmod 0700  $temp/acme-dns.sh      
```

3. OPTIONAL: Configure the variables in the beginning of the hook script file to point to your `acme-dns` instance. <br>`Example /etc/letsencrypt/acme-dns-auth.py:`
```python
07.  ### EDIT THESE: Configuration values ###
08. 
09.  # URL to acme-dns instance
10.  ACMEDNS_URL = "https://auth.acme-dns.io"
11.  # Path for acme-dns credential storage
12.  STORAGE_PATH = "/etc/letsencrypt/acmedns.json"
13.  # Whitelist for address ranges to allow the updates from
14.  # Example: ALLOW_FROM = ["192.168.10.0/24", "::1/128"]
15.  ALLOW_FROM = []
16.  # Force re-registration. Overwrites the already existing acme-dns accounts.
17.  FORCE_REGISTER = False
```

## Usage

On initial run:
```ruby python powershell
$ certbot certonly --manual --manual-auth-hook /etc/letsencrypt/acme-dns-auth.py --preferred-challenges dns --debug-challenges -d example.org -d \*.example.org      
```
Note that the `--debug-challenges` is mandatory here to pause the Certbot execution before asking Let's Encrypt to validate the records and let you to manually add the CNAME records to your main DNS zone.

After adding the prompted CNAME records to your zone(s), wait for a bit for the changes to propagate over the main DNS zone name servers. This takes anywhere from few seconds up to a few minutes, depending on the DNS service provider software and configuration. Hit enter to continue as prompted to ask Let's Encrypt to validate the records.

After the initial run, Certbot is able to automatically renew your certificates using the stored per-domain `acme-dns` credentials. 
