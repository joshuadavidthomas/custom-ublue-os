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

rm -f /etc/yum.repos.d/vivaldi.repo

mv /var/opt/1Password /usr/lib/vivaldi

rm /usr/bin/{vivaldi,vivaldi-"$RELEASE_CHANNEL"}
ln -s /opt/vivaldi/vivaldi /usr/bin/vivaldi
ln -s /opt/vivaldi/vivaldi-"$RELEASE_CHANNEL" /usr/bin/vivaldi-"$RELEASE_CHANNEL"

cat >/usr/lib/tmpfiles.d/vivaldi.conf <<EOF
L  /opt/vivaldi  -  -  -  -  /usr/lib/vivaldi
EOF
