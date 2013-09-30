# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu-12.04.2-x86_64"
  config.vm.box_url =
    "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box"
  config.vm.provision :puppet do |p|
    p.module_path = "puppet/modules"
    p.manifests_path = "puppet/manifests"
    p.manifest_file = "site.pp"
  end

  config.vm.define :puppet do |puppet|
    puppet.vm.hostname = "puppet.lab"
    puppet.vm.network :private_network, ip: "192.168.100.10"
    puppet.vm.provider "virtualbox" do |v|
      v.name = "puppet.lab"
      v.customize [
        "modifyvm", :id,
        "--memory", "1024",
        "--cpus", "2",
        "--groups", "/Vagrant"
      ]
    end
  end
end
