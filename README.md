# Software Versions:
    OS: Win10
    VirtualBox 6.1.26 r145957 (Qt5.6.2)
    Vagrant 2.4.1
    Ansible 2.6 on Ansible host (autoinstall by ansible_host.sh)
###########################
#### CEPHADM                           
###########################
```bash
vagrant up                              # поднимутся 6 ВМ: 3*mon и 3*osd. Если что то пошло не так, всегда есть 'vagrant destroy -f' - убить все ВМ
vagrant ssh mon1                        # подключаемся к монитору1
sudo passwd root                        # меняем пароль руту (и так на каждом хосте. подключаемся, например, ssh mon3 от юзера 
                                        # vagrant с паролем vagrant(если потребуется))
                                        #------------------------------------------------
sudo -i                                 # мама, я админ(root)!
# ОТ РУТА генерим ssh-сертификат и разливаем его на остальные хосты:
ssh-keygen
ssh-copy-id mon2
......
ssh-copy-id osd3
#-----------------------------------------------------------
apt install -y cephadm ceph-common      # ставим всякие нужные приколюхи
mkdir /etc/apt/keyrings
cephadm bootstrap --mon-ip 192.168.0.41 # пилим первый наш монитор!





```
Результат:
```
 Ceph Dashboard is now available at:

             URL: https://mon1:8443/
            User: admin
        Password: nhz453i2yi1

 You can access the Ceph CLI with:

         sudo /usr/sbin/cephadm shell --fsid 34024aac-2d6e-11ef-9211-913d14da3723 -c /etc/ceph/ceph.conf -k /etc/ceph/ceph.client.admin.keyring

 Please consider enabling telemetry to help improve Ceph:

         ceph telemetry on

 For more information see:

         https://docs.ceph.com/docs/master/mgr/telemetry/

 Bootstrap complete.
```