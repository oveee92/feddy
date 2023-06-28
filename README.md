# Role Name

Configure a fresh fedora OS with my preferred setup

## Requirements

- A clean install of Fedora, either GNOME or XFCE4 (make sure to set the `feddy_environment` variable correctly for XFCE).
- A regular user with sudo access

## Role Variables

Check out `defaults/main.yml`

## Dependencies

- git must be installed
- ansible must be available (preferrably with pip)
- community.general collection (for copr / whiskermenu)

## Example installation

Log into the fedora desktop with your user, open the terminal and paste the following:

```bash
# Install git and ansible
sudo dnf install git python3-pip -y
python3 -m pip install ansible --user
ansible-galaxy collection install community.general

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

# Run the ansible setup
ansible-playbook install.yml -K

# Update and reboot (you might have to re-enter your sudo password at this point, the playbook takes 5+ minutes to run the first time)
sudo dnf update -y
reboot
```

## Post-installation stuff


### Dropbox / Google Drive / etc

Run `rclone config` and set up your cloud accounts. Follow something like [this guide](https://ostechnix.com/how-to-mount-google-drive-locally-as-virtual-file-system-in-linux/).
D

Then create the folder in your home directory (e.g. `mkdir ~/GoogleDrive`). Make sure to name your rclone remote the same as the mount directory in your home folder. For example, name it **GoogleDrive** if you plan to mount it to `~/GoogleDrive`.

Then run the command `systemctl --user enable rclone@GoogleDrive --now` if you always want it mounted, or just `systemctl --user start rclone@GoogleDrive` for a temporary mount.

**Note** that this will mount the folders "traditionally", only fetching the files you need when you need them, not taking up space on your local fileystem/disk. For accessing a file multiple times, vfs will cache the files to make subsequent access faster, but for things like listing all files on the mount, searching through them, etc. it will be VERY slow (2-3 files per second slow, depending on the API limitations and network bandwidth). 

To make it more snappy, consider using `rclone sync` and `rclone copy` to clone the files to local, then set up a cron job to automatically sync every 10 minutes or so to sync changes back to the cloud. Note that this is a one-way sync process and potentially destructive on the destination, and the files will take up space on your hardisk as well as in the cloud. You might just want to use this technique for backup, not "daily use".

For proper two-way sync to the local filesystem you should use a client, like dropbox. Might also want to take a look at InSync.

### Dropbox daemon

If using the dropbox daemon, after installation and reboot, find the link to register to dropbox with `systemctl status dropbox --user` or `journalctl --user -u dropbox`. You might have to run `systemctl restart dropbox --user` after registering.


### Others 

- Log into online accounts, mail, etc.

- Set up your KeepassXC file (maybe from cloud storage?)

- Set up / import your Obsidian vault (maybe from cloud storage).

- Log into and set up VSCode.
  - Remote explorer
  - Git integration
  - others?

- Set up colorscheme for terminal
  - https://draculatheme.com/gnome-terminal
  - maybe install the solarized dircolors too, from the script

- Install GNOME shell extensions
  - Extensions manager if available
  - Tweaks
  - GSConnect ? Mostly for fun i guess
  - AppIndicator and KStatusNotifier Support

- Beautify your libreoffice setup
  - Tabbed setup
  - better icon sets

- Download some ISOs for libvirt or boxes

Have fun!


## Example playbooks

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
