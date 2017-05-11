require 'dotenv/load'

VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Configure The Box
  config.vm.box = ENV['VM_BOX']
  config.vm.hostname = ENV['VM_HOSTNAME']

  # Don't Replace The Default Key https://github.com/mitchellh/vagrant/pull/4707
  config.ssh.insert_key = false

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', '2048']
    vb.customize ['modifyvm', :id, '--natdnsproxy1', 'on']
    vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
  end

  # Configure Port Forwarding
  config.vm.network 'forwarded_port', guest: 80, host: 8000, auto_correct: true

  config.vm.synced_folder './', '/vagrant', disabled: true

  # Run The Base Provisioning Script
  config.vm.provision 'shell', path: './scripts/update.sh'
  config.vm.provision :reload

  # Base Packages
  config.vm.provision "shell", path: "./scripts/base.sh"

  # Optimize base box
  config.vm.provision "shell", path: "./scripts/base_box_optimizations.sh"

  # PHP
  config.vm.provision "shell", path: "./scripts/install-php.sh", args: [ENV['PHP_VERSION']]

  # NodeJS
  config.vm.provision "shell", path: "./scripts/install-nodejs.sh", args: [ENV['NODEJS_VERSION']]

  # Nginx
  config.vm.provision "shell", path: "./scripts/install-nginx.sh"

  # MySQL
  config.vm.provision "shell", path: "./scripts/install-mysql.sh", args: [ENV['MYSQL_VERSION'], ENV['MYSQL_PASSWORD']]

  # PostgreSQL
  # config.vm.provision "shell", path: "./scripts/install-pgsql.sh", args: ['secret']

  # SQLite
  # config.vm.provision "shell", path: "./scripts/install-sqlite.sh"

  # Blackfire
  config.vm.provision "shell", path: "./scripts/install-blackfire.sh"

  # Memcached
  config.vm.provision "shell", path: "./scripts/install-memcached.sh"

  # Redis
  config.vm.provision "shell", path: "./scripts/install-redis.sh"

  # Beanstalkd
  config.vm.provision "shell", path: "./scripts/install-beanstalkd.sh"

  # MailHog
  config.vm.provision "shell", path: "./scripts/install-mailhog.sh"

  # Supervisord
  config.vm.provision "shell", path: "./scripts/install-supervisord.sh"

  # ngrok
  config.vm.provision "shell", path: "./scripts/install-ngrok.sh"

  # Clean up
  config.vm.provision "shell", path: "./scripts/clean.sh"
end
