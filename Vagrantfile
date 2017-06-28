# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure('2') do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = 'ubuntu/xenial64'

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network :forwarded_port, guest: 3000, host_ip: '127.0.0.1', host: 3000

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.
  config.vbguest.auto_update = false

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision 'shell', privileged: true, inline: <<-BASH
    # reduce terminal chatter by setting your locale
    echo 'Setting locale'
    locale-gen en_US.UTF-8
    
    # install ruby dependencies
    echo 'Installing dependencies'
    apt-get update -y
    apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev \
                       libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev \
                       libgdbm3 libgdbm-dev libsqlite3-0 libsqlite3-dev git \
                       nodejs imagemagick postgresql libpq-dev
  BASH

  config.vm.provision 'shell', privileged: false, inline: <<-BASH
    echo 'Installing rbenv'

    RBENV_VERSION='e60ad4a0908074f9f7638c75f5cddb377ff6cfcb'
    if cd ~/.rbenv && git rev-parse --verify HEAD | grep -q $RBENV_VERSION; then
        echo 'rbenv already downloaded at expected version'
    else
        git clone https://github.com/rbenv/rbenv.git ~/.rbenv
        cd ~/.rbenv && git checkout $RBENV_VERSION && src/configure && make -C src
    fi
    
    RBBUILD_VERSION='74d1a031adab395c547aeb90d4f89f8d7ddbea2d'
    if cd ~/.rbenv/plugins/ruby-build && git rev-parse --verify HEAD | grep -q $RBBUILD_VERSION; then
        echo 'ruby-build already downloaded at expected version'
    else
        git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
        cd ~/.rbenv/plugins/ruby-build && git checkout $RBBUILD_VERSION
    fi

    RBENV_PATH='export PATH="$HOME/.rbenv/bin:$PATH"'
    RBENV_INIT='eval "$(rbenv init -)"'
    if grep -q "$RBENV_PATH;$RBENV_INIT" ~/.bashrc ; then
        echo 'rbenv thingamajigs already in ~/.bashrc'
    else
        echo "$RBENV_PATH;$RBENV_INIT\n\n$(cat ~/.bashrc)" > ~/.bashrc
    fi
  BASH

  config.vm.provision 'shell', privileged: false, inline: <<-BASH
    echo 'Installing ruby 2.4.1'

    rbenv install -s 2.4.1
    rbenv global 2.4.1
    rbenv rehash
  BASH

  config.vm.provision 'shell', privileged: false, inline: <<-BASH
    echo 'Installing bundler and rails'

    gem install bundler rake --no-rdoc --no-ri
    rbenv rehash
    
    echo 'Running `bundle install`'
    cd /vagrant
    bundle install
    rbenv rehash
    
    echo 'Initializing database'
    bundle exec rake db:create
    bundle exec rake db:schema:load
    bundle exec rake db:seed

    echo -e 'Done!'
  BASH
end
