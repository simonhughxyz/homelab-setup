# 📝 BIND DNS Configuration

This BIND configuration has been **set up for my homelab** using **Slackware**. It includes both **authoritative and recursive DNS** so it can **resolve local domains and cache external lookups**. If you need to adjust it for another network, you may need to update:

- **Zone Files** in `/var/named/zones/`
- **named.conf** in `/etc/named.conf`
- **Root Zone File** if resolving external domains
- **Dynamic DNS (DDNS) Settings** if using DHCP updates

**Also make sure your firewall allows incoming connections on port 53**

---

## 📂 Install

### **Main Configuration (`named.conf`)**

Place the main BIND config file at:

```
/etc/named.conf
```

This bind config is set up for my personal home-lab, if you want to adapt it you
will need to change the ip subnets in the `listen-on`, `allow-query` and
`allow-recursion` definitions:

``` conf
  // listen on internal lan interface and loopback
  listen-on { localhost; 10.0.11.1; 10.0.12.1; 10.0.13.1; };

  // disable ipv6
  listen-on-v6 { none; };

  // allow queries from localhost, internal lan, vpn and network namespace
  allow-query { localhost; 10.0.11.0/24; 10.0.12.0/24; 10.0.13.0/24; };

  /*
   * If there is a firewall between you and nameservers you want
   * to talk to, you might need to uncomment the query-source
   * directive below.  Previous versions of BIND always asked
   * questions using port 53, but BIND 8.1 uses an unprivileged
   * port by default.
   */
  // query-source address * port 53;

  allow-recursion {
      10.0.11.0/24;
      10.0.12.0/24;
      10.0.13.0/24;
      localhost;
  };
```

You may also need to change the domain definitions to match your network setup:

``` conf
zone "mo-net.lan" { type master;
    file "zones/mo-net.lan.zone";
    journal "/var/lib/bind/journal/mo-net.lan.zone.jnl";
    allow-update { key "ddns-key"; };
};

zone "10.0.11.in-addr.arpa" {
    type master;
    file "zones/10.0.11.zone";
    journal "/var/lib/bind/journal/10.0.11.zone.jnl";
    allow-update { key "ddns-key"; };
};
```

## Downloading the Root Zone File

If you want to resolve external domains, you need the root zone file.

Download the latest root hints:

``` bash
wget -O /var/named/root.zone https://www.internic.net/domain/named.root
```

## Dynamic DNS (DDNS) Setup

This bind config uses Dynamic DNS to allow the dhcp server to update the Bind DNS service with the hostnames of the network.

I have written a script to generate the needed ddns key files and save them to the correct locations with correct permissions, it is located in:

```
/scripts/generate_ddns_key.sh
```

This will create and store the key in:
- `/etc/dhcp/ddns.key`
- `/etc/named/ddns.key`

Ensure `named.conf` references `ddns-key` in the zones you want to enable ddns with:

```
allow-update { key "ddns-key"; };
```


## Useful Commands

### Checking BIND Configuration

**Check named.conf for Errors**:
``` bash
named-checkconf
```

**Check Zone Files for Errors:**

``` bash
named-checkzone example.lan /var/named/zones/example.lan.zone
```

### Managing BIND with rndc

**Reload a Single Zone (After Editing):**
``` bash
rndc reload mo-net.lan
```

**Reload All Zones:**

``` bash
rndc reload
```

**Flush DNS Cache:**

``` bash
rndc flush
```

**Check BIND Status:**

``` bash
rndc status
```

**Sync DDNS Updates to the Zone File:**

``` bash
rndc freeze example.lan
rndc sync -clean
rndc thaw mo-net.lan
```

### Querying BIND for Debugging

**Test Forward DNS Resolution:**

``` bash
dig @DNS-IP example.lan
```

**Test Reverse DNS Resolution:**

``` bash
dig @DNS-IP -x REVERSE-IP
```
