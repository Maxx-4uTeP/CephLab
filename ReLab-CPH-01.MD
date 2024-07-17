CPH 01: Введение в Ceph
Нам необходимо настроить ноды и установить дополнительный софт (включая podman)

sudo -i
# Prerequisites
yum groupinstall -y server
yum install -y python3
yum install -y yum-utils

# вписываем хосты в hosts Если нет ДНС Пример ниже
nano /etc/hosts
    127.0.0.1 localhost
    127.0.1.1 ceph1
    192.168.122.101 ceph1.local ceph1

# Отключаем SELinux и FireWall
setenforce 0 && sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
systemctl stop firewalld && systemctl disable firewalld

# Ceph не работает с длинными именами серверов типа ceph1.domain.local. Задаем короткие имена серверу:
hostnamectl set-hostname ceph###

# Обязательно нужно задать пароль к root на всех нодах. Работать будет от root, поэтому правим /etc/ssh/sshd_config и перезапускаем SSH
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
systemctl restart sshd

# ОТ РУТА генерим ssh-сертификат и разливаем его на остальные хосты:
ssh-keygen
ssh-copy-id root@ceph1
......
ssh-copy-id root@ceph###

# Настраиваем синхронизацию времени в /etc/chrony.conf
systemctl enable chronyd.service
systemctl restart chronyd.service

# Можно посмотреть настройки ядра и лимиты ОС
sysctl -a
cat /etc/sysctl.conf
ulimit -a
cat /etc/security/limits.conf

# Устанавливаем репозиторий Ceph
# Скачиваем утилиту cephadm, перемещаем в хранилище bin и даем права на запуск
curl --silent --remote-name --location https://github.com/ceph/ceph/raw/quincy/src/cephadm/cephadm
mv cephadm /usr/local/bin/cephadm
chmod +x /usr/local/bin/cephadm

# Активируем репозиторий
/usr/local/bin/cephadm add-repo --release pacific

# Записываем в bashrc (только для centos 8):
echo ‘export PATH-”$PATH:/usr/local/bin/” ‘ >> .bashrc




