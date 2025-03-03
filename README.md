# 🏠 My Homelab Setup
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)

## Overview
This repository documents my **Linux homelab**, which serves as a **network gateway, VPN server, monitoring system, and self-hosted app hub**.


## Services

This repository contains configurations for various homelab services:

- [DHCP Server](apps/dhcpd/README.md) - ISC DHCPD configuration and setup
- [NTP Server](apps/ntpd/README.md) - NTPD configuration and setup


## Scripts

This repository includes automation scripts to simplify configuration:

- [DDNS Key Generator](scripts/generate-ddns-key.sh) - Generates a secure TSIG key for Dynamic DNS (used by DHCPD and BIND).
