Role Name
=========

Install a Fedora 37 with my preferred setup

Requirements
------------

- A clean install of Fedora 37 XFCE4 edition.
- A regular user with sudo access


Role Variables
--------------

None I guess (yet)

Dependencies
------------

- git must be installed
- ansible must be available (preferrably with pip)

Example installation
--------------------

Log into the fedora desktop with your user, open the terminal and paste the following:

```bash
# Install git and ansible
sudo dnf install git python3-pip -y
python3 -m pip install ansible --user

# Create the folder and the playbook
mkdir -p ~/git/ansible && cd ~/git/ansible
cat << EOF > install.yml
---
- hosts: localhost
  vars:
    custom_hostname: feddy.domain.xyz
  tasks:
    - import_role:
        name: feddy
...
EOF

# Create the role folder and clone this role to it
mkdir roles
git clone https://github.com/oveee92/feddy.git roles/feddy

# Run the ansible setup. '-K' isn't neccesary here as long as you used just sudo a minute ago, but if you
# are running the playbook from a remote server, or the yum/pip stage takes ages, add -K to the next command
ansible-playbook install.yml

# Update and reboot (you might have to re-enter your sudo password at this, point, the playbook takes 5+ minutes)
sudo dnf update -y
reboot
```

After reboot, find the link to register to dropbox with 
`systemctl status dropbox --user`. You might have to run
`systemctl restart dropbox --user` after registering.


Example playbooks
-----------------
```yaml
---
- hosts: localhost
  vars:
    custom_hostname: feddy.domain.xyz
  tasks:
    - import_role:
        name: feddy
...
```

License
-------

Apache-2.0


Author Information
------------------

Me
