# Software Versions:
    OS: Win10
    VirtualBox 6.1.26 r145957 (Qt5.6.2)
    Vagrant 2.4.1
    Ansible 2.6 on Ansible host (autoinstall by ansible_host.sh)
###########################
#### CEPHADM                           
###########################
```bash
vagrant up #поднимутся 6 ВМ: 3*mon и 3*osd

vagrant ssh mon1

sudo -i
apt install -y cephadm ceph-common

cephadm bootstrap --mon-ip 192.168.0.41
```
Результат:
```
 Ceph Dashboard is now available at:

              URL: https://mon1:8443/
             User: admin
         Password: bgl1widh401

 You can access the Ceph CLI with:

         sudo /usr/sbin/cephadm shell --fsid 34024aac-2d6e-11ef-9211-913d14da3723 -c /etc/ceph/ceph.conf -k /etc/ceph/ceph.client.admin.keyring

 Please consider enabling telemetry to help improve Ceph:

         ceph telemetry on

 For more information see:

         https://docs.ceph.com/docs/master/mgr/telemetry/

 Bootstrap complete.
```