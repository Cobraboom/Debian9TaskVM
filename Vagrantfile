# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Образ VM с Vagrant Cloud
  config.vm.box = "debian/stretch64"
  config.vm.box_version = "9.9.0"
  config.vm.synced_folder ".", "/vagrant"
  # Игнорируем vagrant файл из бокса
  config.vm.ignore_box_vagrantfile = false
  # Задаем имя хоста
  config.vm.hostname = "Debian9TaskVM"
  # Указываем тип работы сети (Приватная или публичная)
  #config.vm.network "public_network", ip: '192.168.1.100'
  # Пробрасываем порты для nginx и apache2
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 8888, host: 8888
  #config.vm.network "forwarded_port", guest: 22, host: 2222

  #Указываем провайдера
  config.vm.provider "virtualbox" do |vb|

    vb.name = "Debian9TaskVM"
    # Указываем количество ядер процессора для VM
    vb.cpus = 2
    # Указываем будет ли использоваться графический интерфейс VirtualBox в момент установки
    vb.gui = false
    # Задаем размер ОЗУ
    vb.memory = "2048"
    # Создаем VHDD и подключаем его к VM
    #vb.customize ["createmedium","--filename","VMS.VHD","--size","10240","--format","VHD","--variant","Standard"]
    # Создаем SATA контроллер для подключения VHDD к VM
    #vb.customize ["storagectl","DebianTaskVM","--name","SATA Controller","--add","sata"]
    # Подключаем VHDD к VM
    #vb.customize ["starogeattach","DebianTaskVM","--storagectl","SATA Controller","--device","0","--port","0","--type","hdd","--medium","VMS.VHD"]

  end

  #config.vm.network "private_network", type: "dhcp"
  #config.ssh.username = 'vagrant'
  #config.ssh.password = 'vagrant'
  #config.ssh.private_key_path = '~/.ssh/id_rsa', '~/.ssh/id_rsa.pub'
  #config.ssh.keys_only = false
  #config.ssh.insert_key = false
  config.ssh.port = 2222
  


  #config.vm.provision "shell", path: "provision.sh"
  config.vm.provision "ansible", playbook: "playbook.yml"
  #config.vm.provision "ansible", playbook: "UpdatePHP.yml"



end
