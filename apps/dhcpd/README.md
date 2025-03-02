# DHCP Server Configuration

This DHCP server configuration has been **pre-configured for my homelab** setup using **slackware**. However, if you need to adjust it for another network, you may need to update the following settings:

- **Subnet and IP Range** in `/etc/dhcpd.conf`
- **Router and DNS Server IPs** in `/etc/dhcpd.conf`
- **Network Interface** in `/etc/rc.d/rc.dhcp` (set to `eth1` by default)
- **Dynamic DNS Key** if using a different key name or location

---

## Configuration Files

### DHCP Configuration (`dhcpd.conf`)

Place the DHCP configuration file at:

```
/etc/dhcpd.conf
```

Adjust routers, servers and domains names if needed
Example:

```
subnet 10.0.11.0 netmask 255.255.255.0 {
  range 10.0.11.100 10.0.11.199;
  option domain-name "mo-net.lan";
  option domain-search "mo-net.lan";
}
```

### DHCP Startup Script (`rc.dhcp`)

Ensure the DHCP startup script is located at:

```
/etc/rc.d/rc.dhcp
```

Make it executable:

```
chmod +x /etc/rc.d/rc.dhcp
```

Edit `/etc/rc.d/rc.dhcp` to specify the correct interface (by default set to `eth1`):

```
DHCPD_OPTIONS="-q eth1"
```

You can find out your network interfaces with:

```
ip link
```

---

## Dynamic DNS (DDNS) Setup


I have written a script to generate the needed ddns key files and save them to the correct locations with correct permissions, it is located in:

```
/scripts/generate_ddns_key.sh
```

This will create and store the key in:
- `/etc/dhcp/ddns.key`
- `/etc/named/ddns.key`

Ensure `dhcpd.conf` references `ddns-key`:

```
include "/etc/dhcp/ddns.key";

zone mo-net.lan. {
  primary 10.0.11.1;
  key ddns-key;
}

zone 10.0.11.in-addr.arpa. {
  primary 10.0.11.1;
  key ddns-key;
}
```

---

## Starting the DHCP Server

Start the DHCP server:

```
/etc/rc.d/rc.dhcp start
```

Check if it is running:

```
ps aux | grep dhcpd
```

Restart if needed:

```
/etc/rc.d/rc.dhcp restart
```
