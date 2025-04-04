# 🏠 My Homelab Setup
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)

This repository contains the configuration for my homelab, built around Ansible for automation and containerized services on Debian.

It replaces my previous setup, which was more traditionally managed and manually configured. That earlier configuration is now archived here: 👉 [old-homelab (archived)](https://github.com/simonhughxyz/homelab-setup-slackware)

---

## 📁 Project Structure

```plaintext
ansible-homelab/
├── inventories/
│   ├── development/      # Dev environment hosts + vars
│   └── production/       # Production environment
├── playbooks/
│   ├── setup-dhcpd.yml   # Deploy DHCP server
│   └── site.yml          # Main entry point
├── roles/
│   ├── dhcpd/             # DHCP server setup (ISC)
    └── user_management/  # Manage system users
├── ansible.cfg
└── README.md
```

## 📦 Roles

This repository is organized into modular roles to manage various infrastructure components.

| Role Name         | Description                                              |
|-------------------|----------------------------------------------------------|
| [`user_management`](roles/user_management/README.md) | Manages system users declaratively (shell, groups, etc.) |
| [`dhcpd`](roles/dhcpd/README.md)                 | Installs and configures ISC DHCP server with subnet, lease, and interface options |
