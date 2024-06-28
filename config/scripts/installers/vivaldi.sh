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

find / -type d -name 'vivaldi' 2>&1 | grep -v 'Permission denied' >&2

# Move Vivaldi binary to /usr/bin
mv /var/opt/vivaldi/vivaldi /usr/bin/

# Create symlink for vivaldi-stable if it doesn't exist
ln -sf /usr/bin/vivaldi /usr/bin/vivaldi-"$RELEASE_CHANNEL"

# Move Vivaldi files to /usr/lib/vivaldi
mkdir -p /usr/lib/vivaldi
mv /var/opt/vivaldi /usr/lib/

# Create necessary symlinks
ln -sf /usr/lib/vivaldi/vivaldi /usr/bin/vivaldi
ln -sf /usr/lib/vivaldi/vivaldi-stable /usr/bin/vivaldi-stable
ln -sf /usr/lib/vivaldi/vivaldi-bin /usr/bin/vivaldi-bin

# Set up tmpfiles.d configuration
cat >/usr/lib/tmpfiles.d/vivaldi.conf <<EOF
L /var/opt/vivaldi - - - - /usr/lib/vivaldi
EOF

find / -type d -name 'vivaldi' 2>&1 | grep -v 'Permission denied' >&2
