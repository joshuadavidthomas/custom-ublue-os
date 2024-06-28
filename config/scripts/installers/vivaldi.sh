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

mv /var/opt/vivaldi/vivaldi /usr/bin/

mkdir -p /usr/lib/vivaldi
mv /var/opt/vivaldi /usr/lib/

rm -f /etc/yum.repos.d/vivaldi.repo

find /usr/lib -type d -name 'vivaldi' 2>&1 | grep -v 'Permission denied' >&2
