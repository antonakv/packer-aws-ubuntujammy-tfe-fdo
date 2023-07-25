#!/usr/bin/env bash

set -euox pipefail

export APTARGS="-qq -o=Dpkg::Use-Pty=0"
export DEBIAN_FRONTEND=noninteractive

DEBIAN_FRONTEND=noninteractive apt-get --assume-yes clean ${APTARGS}
DEBIAN_FRONTEND=noninteractive rm -rf /var/lib/apt/lists/partial/
DEBIAN_FRONTEND=noninteractive apt-get --assume-yes update ${APTARGS}

DEBIAN_FRONTEND=noninteractive apt-get --assume-yes upgrade ${APTARGS}

DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes ${APTARGS} htop git vim curl wget tar software-properties-common htop unattended-upgrades gpg-agent apt-transport-https ca-certificates thin-provisioning-tools

unattended-upgrades -v

DEBIAN_FRONTEND=noninteractive apt-get -y update ${APTARGS}

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

DEBIAN_FRONTEND=noninteractive apt-get -y update ${APTARGS}

DEBIAN_FRONTEND=noninteractive apt-get -y install net-tools containerd libseccomp2 awscli jq neovim unzip ${APTARGS}

curl -s https://packagecloud.io/install/repositories/netdata/netdata/script.deb.sh | DEBIAN_FRONTEND=noninteractive bash

DEBIAN_FRONTEND=noninteractive apt-get --assume-yes update ${APTARGS}

DEBIAN_FRONTEND=noninteractive apt-get --assume-yes install netdata ${APTARGS}

DEBIAN_FRONTEND=noninteractive apt-get -y install net-tools docker-ce=5:23.0.6-1~ubuntu.22.04~jammy docker-ce-cli=5:23.0.6-1~ubuntu.22.04~jammy containerd.io awscli jq neovim unzip ${APTARGS}

DEBIAN_FRONTEND=noninteractive sudo apt-mark hold docker docker-ce docker-compose-plugin docker-ce-rootless-extras docker-ce-cli docker-buildx-plugin ${APTARGS}

systemctl enable netdata.service

echo "$(date +"%T_%F") containerd version"

containerd --version

echo "$(date +"%T_%F") runc version"

runc --version

echo "$(date +"%T_%F") docker version"

docker --version
