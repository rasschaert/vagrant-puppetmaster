# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Using CentOS 6
  config.vm.box = "centos-6.4-x86_64"
  # config.vm.box_url =
    "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box"

  # Provisioning
  config.vm.provision :puppet do |p|
    p.module_path = "bootstrap/modules"
    p.manifests_path = "bootstrap/manifests"
    p.manifest_file = "site.pp"
  end

  # VirtualBox settings
   config.vm.provider "virtualbox" do |v|
    v.customize [
      "modifyvm", :id,
      "--memory", "1024",
      "--cpus", "2",
      "--groups", "/Vagrant"
    ]
  end

  # Puppet Master VM definition
  config.vm.define :puppet do |puppet|
    puppet.vm.hostname = "puppet.vagrant.local"
    puppet.vm.network :private_network, ip: "192.168.100.10"
    puppet.vm.provider("virtualbox") { |v| v.name = "puppet" }
  end
end
