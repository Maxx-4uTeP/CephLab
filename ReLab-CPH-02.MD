# CPH 02: Разбор компонентов кластера

cephadm install ceph-common
ip a
if [[ ! -d "/etc/ceph" ]]; then sudo mkdir -p /etc/ceph;fi
/usr/local/bin/cephadm bootstrap --mon-ip _10.129.0.20_ --initial-dashboard-user itclife  --initial-dashboard-password itclife --dashboard-password-noupdate