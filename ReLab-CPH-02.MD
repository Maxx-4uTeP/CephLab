# CPH 02: Разбор компонентов кластера

```bash
cephadm install ceph-common
if [[ ! -d "/etc/ceph" ]]; then sudo mkdir -p /etc/ceph;fi
ip a
 
# ceph1 10.129.0.24
/usr/local/bin/cephadm bootstrap --mon-ip 10.129.0.24 --initial-dashboard-user itclife --initial-dashboard-password itclife --dashboard-password-noupdate
# ceph2 10.129.0.11
/usr/local/bin/cephadm bootstrap --mon-ip 10.129.0.11 --initial-dashboard-user itclife --initial-dashboard-password itclife --dashboard-password-noupdate
# ceph3 10.129.0.28
/usr/local/bin/cephadm bootstrap --mon-ip 10.129.0.28 --initial-dashboard-user itclife --initial-dashboard-password itclife --dashboard-password-noupdate


```
























