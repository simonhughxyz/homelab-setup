# dhcpd Role

This role installs and configures the ISC DHCP server (`isc-dhcp-server`) on Debian-based systems.

## Features

- Installs the `isc-dhcp-server` package
- Deploys a configurable `dhcpd.conf` using a Jinja2 template
- Sets interface binding in `/etc/default/isc-dhcp-server`
- Enables and starts the DHCP service via systemd
- Supports custom subnet, lease range, routers, DNS, and NTP options

## Variables

All configuration is driven by variables that can be defined in `group_vars`, `host_vars`, or directly in your playbook.

### Example minimal config:

```yaml
# Network and lease configuration
dhcp_interface: eth1

dhcp_subnet: 10.0.11.0
dhcp_netmask: 255.255.255.0
dhcp_range_start: 10.0.11.100
dhcp_range_end: 10.0.11.199
dhcp_router: 10.0.11.1

# Optional DHCP options
dhcp_domain_name: mo-net.lan
dhcp_ntp: ntp.mo-net.lan
```

## Usage

Include this role in your playbook:

``` yaml
- name: Set up DHCP server
  hosts: gateway
  become: true
  roles:
    - dhcpd
```

And define the necessary variables in your inventory or group_vars.

## Notes
- The DHCP interface is written to /etc/default/isc-dhcp-server using lineinfile.
- Assumes Debian-based distributions (e.g., Debian, Ubuntu).
