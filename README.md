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
│   ├── deploy-dhcp.yml   # Deploy DHCP server
│   └── site.yml          # Main entry point
├── roles/
│   ├── dhcp/             # DHCP server setup (ISC)
├── ansible.cfg
└── README.md
