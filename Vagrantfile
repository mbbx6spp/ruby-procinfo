# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "desk-precise"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://artifacts-dev.s3.amazonaws.com/vagrant/desk-precise.box"

  # SSH configuration
  config.ssh.default.username = "ubuntu"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  #config.vm.network :forwarded_port, guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network :private_network, ip: "192.168.33.11"

  config.vm.synced_folder ".", "/mnt"

  # Provision using Shell

  # Provision using Puppet apply
  #config.vm.provision :puppet do |puppet|
  #  puppet.manifests_path = "./manifests"
  #  puppet.module_path = [
  #    "./modules",
  #  ]
  #  puppet.manifest_file = "vagrant.pp"
  #  puppet.options = "--verbose --debug"
  #  puppet.facter = {
  #    environment:  'vagrant',
  #    domain:       'desk.local',
  #  }
  #end
end
