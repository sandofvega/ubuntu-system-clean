#!/bin/bash

# Remove packages that are no longer required
sudo apt autoremove -y

# Clean up APT cache
sudo apt clean

# Clear systemd journal logs, but keep last 1 day's log
sudo journalctl --vacuum-time=1d

# Clean the thumbnail cache
rm -rf ~/.cache/thumbnails/*

# Removes old revisions of snaps START
set -eu
snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        snap remove "$snapname" --revision="$revision"
    done
# Removes old revisions of snaps END

exit 0
