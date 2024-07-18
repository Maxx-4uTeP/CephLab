# CPH 02: Разбор компонентов кластера
#### Давайте соберем наш кластер. В первую очередь, надо поставить компоненты Ceph-common.
```bash
cephadm install ceph-common
if [[ ! -d "/etc/ceph" ]]; then sudo mkdir -p /etc/ceph;fi
ip a
cat /etc/hosts # Тут все три сервера вписаны
# ceph1 10.129.0.5
# ceph2 10.129.0.35
# ceph3 10.129.0.13
```

#### Добавляем ключи на ceph2 и ceph3:
```bash
ssh-keygen
ssh-copy-id -f -i /etc/ceph/ceph.pub root@ceph2
ssh-copy-id -f -i /etc/ceph/ceph.pub root@ceph3
```
#### Далее ставим кластер через cephadm bootstrap.

```bash
/usr/local/bin/cephadm bootstrap --mon-ip 10.129.0.5 --initial-dashboard-user itclife --initial-dashboard-password itclife --dashboard-password-noupdate
# Так мы поднимем первый монитор, от которого можно будет оттолкнуться и создать кластер. На первом мониторе развернется административный узел
```

#### Передаем хосты под управление Ceph:
```bash
ceph orch host add ceph2 10.129.0.35
ceph orch host add ceph3 10.129.0.13
```

#### Лейблим узлы как мониторы:
```bash
ceph orch host label add ceph1 mon
ceph orch host label add ceph2 mon
ceph orch host label add ceph3 mon
```

#### И как стендбаи MGR:
```bash
ceph orch host label add ceph1 mgr
ceph orch host label add ceph2 mgr
ceph orch host label add ceph3 mgr
```

#### Конфигурируем сеть (на тесте у нас одна). На самом деле, сеть он сконфигурировал, когда ее обнаружил, но лучше дополнительно ее указать:
```bash
ceph config set mon public_network 10.129.0.0/24
```

#### Стартуем мониторы:
```bash
ceph orch apply mon "ceph1,ceph2,ceph3"
```

#### Стартуем MGR:
```bash
ceph orch apply mgr "ceph1,ceph2,ceph3"
```

#### Проверяем количество хостов:
```bash
ceph orch host ls
```

#### Добавление дисков
 Командой lsblk можно посмотреть информацию о диске.
 
 OSD он всегда маркирует по умолчанию, как все компьютерные системы — с нуля. Поэтому на ceph3 у нас будет OSD с номером 2
```bash
ceph orch daemon add osd ceph1:/dev/vdb
ceph orch daemon add osd ceph2:/dev/vdb
ceph orch daemon add osd ceph3:/dev/vdb
```

#### Проверяем статус кластера должно быть HEALTH_OK
```bash
ceph -s
```


#### Копируем настройки:
```bash
scp /etc/ceph/ceph.conf ceph2:/etc/ceph.conf
scp /etc/ceph/ceph.conf ceph3:/etc/ceph.conf
scp /etc/ceph/ceph.client.admin.keyring ceph2:/etc/ceph/ceph.client.admin.keyring
scp /etc/ceph/ceph.client.admin.keyring ceph3:/etc/ceph/ceph.client.admin.keyring
scp /etc/ceph/ceph.pub  ceph2:/etc/ceph/ceph.pub
scp /etc/ceph/ceph.pub  ceph3:/etc/ceph/ceph.pub
```
























