#!/bin/bash
# APT cache ürítése
apt clean

# Cache ürítése
find ~/.cache/ -type f -atime +1 -delete

# .m2 ürítése
find ~/.m2/repository/ -atime +120 -iname '*.pom' | while read pom; do parent=`dirname "$pom"`; rm -Rf "$parent"; done

# Removes old revisions of snaps
# CLOSE ALL SNAPS BEFORE RUNNING THIS
set -eu
snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        snap remove "$snapname" --revision="$revision"
    done
    
# Flatpak
flatpak uninstall --unused | yes
sudo rm -rfv /var/tmp/flatpak-cache-*
