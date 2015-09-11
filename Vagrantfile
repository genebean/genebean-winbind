# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "genebean/centos6-rvm193-64bit"

  if Vagrant.has_plugin?("vagrant-cachier")
    # Configure cached packages to be shared between instances of the same base box.
    # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
    config.cache.scope = :box
  end

  config.vm.provision "shell", inline: "yum -y install git"
  config.vm.provision "shell", inline: "su - vagrant -c 'rsync -rv --delete /vagrant/ winbind --exclude bundle; cd winbind; bundle install --jobs=3 --retry=3 --path=${BUNDLE_PATH:-vendor/bundle}'"

end
