# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

        ################################################################################
        # Base box                                                                     #
        ################################################################################
        config.vm.box = "centos-64-x64-vbox4210"
        config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/" +
                "centos-64-x64-vbox4210.box"

        ################################################################################
        # Global provisioning settings                                                 #
        ################################################################################
        config.vm.provision :puppet do |p|
                p.module_path = "bootstrap/modules"
                p.manifests_path = "bootstrap/manifests"
                p.manifest_file = "site.pp"
        end

        ################################################################################
        # Global VirtualBox settings                                                   #
        ################################################################################
        config.vm.provider "virtualbox" do |v|
                v.customize [
                        "modifyvm", :id,
                        "--memory", "1024",
                        "--cpus", "2",
                        "--groups", "/Vagrant"
                ]
        end

        ################################################################################
        # VM definitions                                                               #
        ################################################################################
        # Puppetmaster
        config.vm.define :puppet do |puppet|
                puppet.vm.hostname = "puppet.vagrant.local"
                puppet.vm.network :private_network, ip: "192.168.100.10"
                puppet.vm.provider("virtualbox") { |v| v.name = "puppet" }
                puppet.vm.synced_folder "master/manifests/", "/etc/puppet/manifests"
                puppet.vm.synced_folder "master/modules/", "/etc/puppet/modules"
        end
        # Web server
        config.vm.define :web do |web|
                web.vm.hostname = "web.vagrant.local"
                web.vm.network :private_network, ip: "192.168.100.11"
                web.vm.provider("virtualbox") { |v| v.name = "web" }
        end

end
