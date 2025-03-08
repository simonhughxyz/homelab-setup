# Monit Configuration for My Homelab

This setup provides **automated service monitoring and recovery** for my homelab.  
Monit ensures that essential services remain up and running, restarting them when needed and notifying me of any issues.

If you're adapting this for your own system, update the scripts and `monitrc` to match your setup.

---

## How It Works

- **Monitors critical services** and **restarts them if they fail**.
- **Alerts when services go down** (I use Gotify notifications).

## Install

### Slackware

Monit can be installed via SlackBuilds or compiled from source.

### Configuration

Place the `monitrc` configuration file at:

``` config
/etc/monitrc
```
And move the monitoring scripts to:

``` config
/etc/monit/
```
And ensure Monit can execute them:

```bash
chmod +x /etc/monit/*.sh
```

## Useful Commands

**Restart Monit after making changes:**

```
monit reload
```


**Check Monit’s status:**

```
monit status
```

**Manually trigger a check:**

```
monit monitor all
```

## Final Notes

- This setup is tailored for my homelab, but you can adjust it to suit your needs.
- Make sure Monit runs as root to manage system services.
- Configure alerts in monitrc for notifications.
