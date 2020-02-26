Vagrant.configure("2") do |config|
    config.vm.define "docker-registry.local" do |foolishness|
      foolishness.vm.box = "bento/ubuntu-16.04"    
      foolishness.vm.network "private_network", ip: "192.168.50.5"
      foolishness.vm.provision :shell, path: "vagrant.sh"
      foolishness.vm.provider "virtualbox" do |vb|
        vb.memory = "512"
        vb.cpus = "2"
        vb.name = "docker-registry.local"
      end
    end
  end