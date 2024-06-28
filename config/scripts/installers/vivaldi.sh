#!/usr/bin/env bash

set -ouex pipefail

# stable or snapshot
RELEASE_CHANNEL="${VIVALDI_RELEASE_CHANNEL:-stable}"

echo "Installing Vivaldi"

mkdir -p /var/opt

cat <<EOF >/etc/yum.repos.d/vivaldi.repo
[vivaldi]
baseurl=https://repo.vivaldi.com/archive/rpm/\$basearch
enabled=1
gpgcheck=1
gpgkey=https://repo.vivaldi.com/archive/linux_signing_key.pub
name=vivaldi
EOF

rpm --import https://repo.vivaldi.com/archive/linux_signing_key.pub

rpm-ostree install vivaldi-"$RELEASE_CHANNEL"

find / -name 'vivaldi*' 2>&1 | grep -v 'Permission denied' >&2
readlink /usr/bin/vivaldi
readlink /usr/bin/vivaldi-stable

# Ensure the destination directory exists
mkdir -p /usr/lib/vivaldi

# Move Vivaldi directory contents to /usr/lib/vivaldi/
mv /var/opt/vivaldi /usr/lib/

# Create necessary symlinks
ln -sf /usr/lib/vivaldi/vivaldi-bin /usr/bin/vivaldi-bin
ln -sf /usr/lib/vivaldi/vivaldi-bin /usr/bin/vivaldi
ln -sf /usr/lib/vivaldi/vivaldi-bin /usr/bin/vivaldi-stable

# Set up tmpfiles.d configuration
cat >/usr/lib/tmpfiles.d/vivaldi.conf <<EOF
L /var/opt/vivaldi - - - - /usr/lib/vivaldi
EOF

find / -name 'vivaldi*' 2>&1 | grep -v 'Permission denied' >&2
