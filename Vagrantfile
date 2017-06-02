# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.hostname = "hspc-reference-platform"
  config.vm.box = "bento/ubuntu-16.04"

# MYSQL Database
  config.vm.network :forwarded_port, guest: 3306, host: 3307

# Auth Server
  config.vm.network :forwarded_port, guest: 9060, host: 9060
# Account Server
  config.vm.network :forwarded_port, guest: 9065, host: 9065

# API_DSTU2 Server
  config.vm.network :forwarded_port, guest: 9071, host: 9071
# API_STU3 Server
  config.vm.network :forwarded_port, guest: 9074, host: 9074

# Sandbox Manager
  config.vm.network :forwarded_port, guest: 9080, host: 9080
# Gallery
  config.vm.network :forwarded_port, guest: 9085, host: 9085
# bilirubin-risk-chart
  config.vm.network :forwarded_port, guest: 9086, host: 9086
# bilirubin-monitor
  config.vm.network :forwarded_port, guest: 9087, host: 9087
# bilirubin_cds_hooks
  config.vm.network :forwarded_port, guest: 9088, host: 9088

# Messaging Server
  config.vm.network :forwarded_port, guest: 9091, host: 9091
# Apps Server
  config.vm.network :forwarded_port, guest: 9093, host: 9093
# Patient Picker Server
  config.vm.network :forwarded_port, guest: 9094, host: 9094
# Appointments
  config.vm.network :forwarded_port, guest: 9095, host: 9095
# Patient Data Manager
  config.vm.network :forwarded_port, guest: 9096, host: 9096

  config.vm.provider "virtualbox" do |vb|
    vb.name = "HSPC Reference Platform"
    vb.memory = "5120"
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.customize ["modifyvm", :id, "--cableconnected1", "on"]
  end

  config.vm.provision "fix-no-tty", type: "shell" do |s|
    s.privileged = false
    s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
  end

#  config.vm.provision "ansible" do |ansible|
#    ansible.verbose="vvvv"
#    ansible.playbook = "provisioning/site.yml"
#  end

  # If you are running the build on a Windows host, please comment out the
  # "ansible" provisioner above and use this "shell" provisioner:
  #
  # config.vm.provision "shell", path: "provisioning/provision-on-guest.sh"

end
