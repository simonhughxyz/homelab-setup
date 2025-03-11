# Gotify Setup for My Homelab

This is my self-hosted notification system, running behind an Nginx reverse proxy. It lets my servers send me real-time alerts when things happen—backups finish, services go down, VPN connects, etc.

If you're setting this up yourself, you'll probably need to tweak the reverse proxy settings and authentication—see below.

---

## How It Works

- Runs Gotify as a background service on my homelab.
- Sits behind Nginx (no direct internet exposure).
- Uses API tokens for sending notifications.
- Logs everything to keep track of messages.

## Install

### Slackware

Gotify is a single binary. Just download and place it in `/usr/local/bin`:

``` bash
wget -O /usr/local/bin/gotify https://github.com/gotify/server/releases/latest/download/gotify-linux-amd64
chmod +x /usr/local/bin/gotify
```

Create a system user for Gotify:

``` bash
useradd -r -s /bin/false gotify
```

Make directories for config and logs:

``` bash
mkdir -p /srv/gotify/data /etc/gotify
chown -R gotify:gotify /srv/gotify /etc/gotify
chmod -R 0750 /srv/gotify /etc/gotify
```

Place the `config.yml` file in:

``` text
/etc/gotify/config.yml
```

And place the `rc.gotify` file in:

``` text
/etc/rc.d/rc.gotify
```

## Configuration

Gotify runs on localhost only (reverse proxy handles public access):

``` yaml
server:
  listenaddr: "127.0.0.1"
  port: 8081
```

Gotify stores its data in /srv/gotify, which is on an encrypted partition. This keeps logs, messages, and tokens secure in case of system compromise:

``` yaml
database:
  connection: /srv/gotify/data/gotify.db
uploadedimagesdir: /srv/gotify/data/images
```

**When Gotify starts for the first time, it creates a default admin user:**

``` yaml
defaultuser:
  name: admin
  pass: admin
```

Either change this in the config or change this through the user interface after starting Gotify

## Sending Notifications

Once Gotify is running, you can send messages using the API:

``` bash
curl "https://push.example.de/message?token=<apptoken>" -F "title=my title" -F "message=my message" -F "priority=5"
```
