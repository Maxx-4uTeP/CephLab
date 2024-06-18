# -*- mode: ruby -*-
# vim: set ft=ruby :
ENV['VAGRANT_SERVER_URL']="https://vagrant.elab.pro" # https://vagrant.elab.pro/downloads/

nodes = [
  #{ :hostname => 'ansible', :ip => '192.168.0.40', :box => 'ubuntu/focal64', :ram => 4096, :ansible => 'yes' }, 
  { :hostname => 'mon1', :ip => '192.168.0.41', :box => 'UbntRoot', :ram => 2048, :mon => 'yes' },
  { :hostname => 'mon2', :ip => '192.168.0.42', :box => 'ubuntu/focal64', :ram => 2048, :mon => 'yes' },
  { :hostname => 'mon3', :ip => '192.168.0.43', :box => 'ubuntu/focal64', :ram => 2048, :mon => 'yes' },
  { :hostname => 'osd1',  :ip => '192.168.0.51', :box => 'CentOsRoot', :ram => 2048, :osd => 'yes' }, # CentOs потому что Ubuntu перестает запускаться после подключения SATA-диска
  { :hostname => 'osd2',  :ip => '192.168.0.52', :box => 'centos/7', :ram => 2048, :osd => 'yes' }, # CentOs потому что Ubuntu перестает запускаться после подключения SATA-диска
  { :hostname => 'osd3',  :ip => '192.168.0.53', :box => 'centos/7', :ram => 2048, :osd => 'yes' }  # CentOs потому что Ubuntu перестает запускаться после подключения SATA-диска
]

Vagrant.configure("2") do |config|
  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.box = node[:box]
      nodeconfig.vm.hostname = node[:hostname]
      nodeconfig.vm.network :private_network, ip: node[:ip]

      memory = node[:ram] ? node[:ram] : 512;
      nodeconfig.vm.provider :virtualbox do |vb|
        vb.customize [ "modifyvm", :id, "--memory", memory.to_s ]
# MONITOR #
        if node[:mon] == "yes" # UBUNTU #
         nodeconfig.vm.provision "shell", inline: <<-SHELL
             apt-get update
             apt-get install python3-pip -y
             ln -sf /usr/bin/python3 /usr/bin/python
           SHELL
      end
# OSD #
      if node[:osd] == "yes" # CENTOS #
          nodeconfig.vm.provision "shell", inline: <<-SHELL
            yum update -y
            yum install python3-pip -y
          SHELL
          # vb.customize ["storagectl", :id, "--name", "SATA", "--add", "sata" ]
           file_to_disk = "./disk_osd-#{node[:hostname]}.vdi"
             unless File.exist?(file_to_disk)
               vb.customize ['createhd', '--filename', file_to_disk, '--size', 10 * 1024]
             end
               vb.customize ["storageattach", :id, "--storagectl", "SATA", "--port", 1, "--device", 0, "--type", "hdd", "--medium", file_to_disk ]
            
      end
# ANSIBLE #     
       if node[:ansible] == "yes"  
         nodeconfig.vm.provision "file", source: "files/hosts", destination: "/tmp/hosts"
         nodeconfig.vm.provision "file", source: "files/ceph", destination: "/tmp/ceph"
         nodeconfig.vm.provision "file", source: "files/osds", destination: "/tmp/osds"
         nodeconfig.vm.provision "shell", path: "files/ansible_host.sh"
       end 
       nodeconfig.vm.provision "shell", inline: <<-SHELL
         sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
         echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
         systemctl restart sshd
       SHELL

    end
  end
    config.hostmanager.enabled = true
    config.hostmanager.manage_guest = true
    #config.ssh.password = 'vagrant'
end
end
