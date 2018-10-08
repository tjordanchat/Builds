#!/bin/bash

# Run this script as root: 
# curl https://raw.githubusercontent.com/tjordanchat/jenkins_setup/master/DO/do_setup.sh | sh

set -x
export DISPLAY=':99'
export TZ='America/New_York'
apt-get update
apt-get -y install openjdk-7-jre-headless
apt-get update
apt-get -y install xvfb
apt-get update
Xvfb :99 -screen 0 1024x768x24 > /dev/null 2>&1 &
wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
dpkg --force-all -i puppetlabs-release-trusty.deb
apt-get -y install ntp 
apt-get update
apt-get -y install puppetmaster
apt-get update
apt-get -y install python-jenkinsapi
apt-get update
apt-get -y install puppet
apt-get update
puppet resource package puppetmaster ensure=latest
puppet resource service puppetmaster ensure=running enable=true
puppet agent
adduser --disabled-password myuser
usermod -aG sudo myuser
mkdir -p ~myuser/.ssh
chown myuser ~myuser/.ssh
chmod 700 ~myuser/.ssh
cp ~/.ssh/authorized_keys ~myuser/.ssh
chown ~myuser/.ssh/authorized_keys
chmod 600 ~myuser/.ssh/authorized_keys
sleep 5
ps -ef | egrep jenkins
netstat -tunpl