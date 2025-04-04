# user_management Role

This role manages system users in a declarative way using Ansible's built-in `user` module.

## Features

- Creates users with custom shell and group membership
- Supports system accounts (e.g. service users)
- Designed to be idempotent and reusable

## Variables

The role expects a variable called `managed_users`, which should be a list of user definitions:

```yaml
managed_users:
  - name: user1
    shell: /bin/bash
    groups: [group1]

  - name: user2
    shell: /usr/sbin/nologin
    system: true
    groups: [group1, group2]
```

Each user supports the following fields:
- `name` (required)
- `shell` (optional, defaults to /bin/bash)
- `groups` (optional), a list of groups the user is a member off
- `system` (optional, defaults to false)

## Usage
Include the role in your playbook:

``` yaml
- name: Create system users
  hosts: all
  become: true
  roles:
    - user_management
```

**Make sure to define managed_users in your inventory or playbook vars.**
