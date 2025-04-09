# network Role

This Ansible role configures and renames network interfaces on Debian-based systems. It uses systemd-networkd and udev rules to ensure predictable interface names and static IP assignment.

## Features

- Renames interfaces based on their MAC address using a udev rule
- Configures static IP addresses or enables DHCP via systemd-networkd
- Displays all detected interfaces and their MAC addresses to aid configuration
- Validates required variables and provides helpful debug output
- Automatically restarts networking and updates initramfs if needed

## Variables

### Required

These variables must be defined in your inventory or group_vars:

```yaml
wan_mac: "02:42:ac:11:00:01"
lan_mac: "02:42:ac:11:00:02"
```

Optionally override the default interface names:

```yaml
wan_name: "eth0"
lan_name: "eth1"
```

### Interface Configuration

Use the interfaces list to configure IPs:

``` yaml
interfaces:
  - name: eth0
    address: 10.0.10.2/24
    gateway: 10.0.2.1
    dns: 127.0.0.1
    dhcp: false

  - name: eth1
    address: 10.0.11.1/24
    dhcp: false
```

*Set `dhcp: true` if the interface should use DHCP instead of a static IP.*

## Handlers

The role includes the following handlers:

- `update initramfs` – called when udev rules are added
- `reboot system` – reboots the machine to apply renaming
- `restart networking` – restarts systemd-networkd after config changes

## Example Playbook

``` yaml
- name: Configure network interfaces and names
  hosts: all
  become: true
  roles:
    - network
```

## Notes

- This role is designed for systemd-based systems (e.g., Debian, Ubuntu).
- Renaming network interfaces via udev requires a reboot to fully apply.
- The role prints all available interfaces and MACs to help you configure wan_mac and lan_mac properly.
