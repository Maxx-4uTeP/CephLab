#!/bin/bash
apt-get update 
apt-get install nano -y 
apt-get install python3-pip -y
pip install ansible==2.6
mkdir /etc/ansible
git clone https://github.com/ceph/ceph-ansible.git
cd ceph-ansible/
git checkout stable-3.2
cd ..
cp -a ceph-ansible/* /etc/ansible/
cp /tmp/hosts /etc/ansible/hosts
cp /tmp/ceph /etc/ansible/group_vars/ceph
cp /tmp/osds /etc/ansible/group_vars/osds
pip install notario netaddr

mkdir /etc/ansible/fetch
chown vagrant /etc/ansible/fetch
mv /etc/ansible/site.yml.sample /etc/ansible/site.yml

