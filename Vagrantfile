# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Build it off an Ubuntu 14.04 x64 box with Puppet preinstalled
  config.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"
  
  # Forward some ports
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  
  # Set CPU count and RAM limits
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
  end
  
  config.vm.provider "vmware_fusion" do |v|
    v.vmx["memsize"] = "1024"
    v.vmx["numvcpus"] = "2"
  end
  
  # Install Puppet modules first thing
  config.vm.provision "shell", path: "provisioning/puppet_install.sh"
  
  # Provision with Puppet
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "provisioning/manifests"
    puppet.manifest_file  = "default.pp"
  end
end
