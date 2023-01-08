Role Name
=========

Role to set up custom Fedora 37 with XFCE4

Requirements
------------

An installed Fedora 37 with XFCE4


Role Variables
--------------

`feddy_user` - The namme of the main user


Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.
Probably `community.general` collection, to be able to use the `ini_file` module. The remainder are just standard ansible modules.


Example Playbook
----------------

You should be able to use this both on localhost, and on a custom server

```yaml
- hosts: localhost
  vars:
    feddy_user: my_username
  roles:
     - role: feddy
```

License
-------

BSD

Author Information
------------------

Ove
