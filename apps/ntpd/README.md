# NTP Configuration for My Homelab

This setup provides **secure and reliable time synchronization** for my homelab using **public NTP servers**. It serves time to internal devices over **LAN (`eth1`)** and **WireGuard VPN (`wg0`)**, while blocking unauthorized access.

If you're adapting this for your own network, you'll need to update **interfaces** and **subnets**—see below.

---

## How It Works

- **Syncs with public NTP servers** (`pool.ntp.org`).
- **Serves time only on my homelab network** (`eth1`) and **WireGuard VPN (`wg0`)**.
- **Blocks all other traffic for security**.

---

## Install

### Slackware

Slackware comes pre-installed with ntpd, so no need to install it.

Place the `ntp.conf` configuration file at:

```
/etc/ntp.conf
```

Create the appropriate directories based on the `ntp.conf` configuration:

``` bash
mkdir -p /var/lib/ntp/stats
mkdir -p /var/log/ntp
```

And assign correct permissions to said directories:

``` bash
chown ntp:ntp /var/lib/ntp
chown ntp:ntp /var/log/ntp
```

And then start the ntpd service:

``` bash
/etc/rc.d/rc.ntpd start
```

## Configuration

### 1️⃣ Listening on the Right Interfaces

By default, NTP only listens on my **LAN and WireGuard VPN**:

``` conf
interface ignore wildcard
interface listen eth1   # LAN interface
interface listen wg0    # WireGuard VPN
```

### Restricting Access

By default, only devices on my LAN (10.0.11.0/24) and VPN (10.0.12.0/24) can sync time:

``` conf
restrict 10.0.11.0 mask 255.255.255.0 limited kod nomodify notrap nopeer
restrict 10.0.12.0 mask 255.255.255.0 limited kod nomodify notrap nopeer
```

Update these subnets to match your LAN and VPN ranges.

### Choosing Time Sources

By default, the config syncs from public NTP pool servers:

``` conf
server 0.pool.ntp.org iburst
server 1.pool.ntp.org iburst
server 2.pool.ntp.org iburst
server 3.pool.ntp.org iburst
```

If you have a local or ISP-provided NTP server, replace these with its address.

### Useful commands

After modifying the config, restart ntp:

**Slackware:**

``` bash
/etc/rc.d/rc.ntpd restart
```

**Fedora / Debian / Arch or any other distro with systemd:**

``` bash
systemctl restart ntpd
```

To check if its working:

``` bash
ntpq -p
```

**To see if NTP is listening only on the correct interfaces:**

``` bash
ss -tulpn | grep ntpd
```



## Final Notes

- This is built for my homelab, but you can adapt it by changing interfaces and subnets.
- Make sure firewalls allow UDP 123 if NTP clients can't connect.
