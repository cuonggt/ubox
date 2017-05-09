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
  config.vm.provision "shell", path: "./scripts/php.sh", args: [ENV['PHP_VERSION']]

  # Nginx
  config.vm.provision "shell", path: "./scripts/nginx.sh"

  # MySQL
  config.vm.provision "shell", path: "./scripts/mysql.sh", args: [ENV['MYSQL_VERSION'], ENV['MYSQL_PASSWORD']]

  # PostgreSQL
  config.vm.provision "shell", path: "./scripts/pgsql.sh", args: ['secret']

  # SQLite
  config.vm.provision "shell", path: "./scripts/sqlite.sh"

  # Blackfire
  config.vm.provision "shell", path: "./scripts/blackfire.sh"

  # Memcached
  config.vm.provision "shell", path: "./scripts/memcached.sh"

  # Redis
  config.vm.provision "shell", path: "./scripts/redis.sh"

  # Beanstalkd
  config.vm.provision "shell", path: "./scripts/beanstalkd.sh"

  # MailHog
  config.vm.provision "shell", path: "./scripts/mailhog.sh"

  # Supervisord
  config.vm.provision "shell", path: "./scripts/supervisord.sh"

  # ngrok
  config.vm.provision "shell", path: "./scripts/ngrok.sh"

  # Clean up
  config.vm.provision "shell", path: "./scripts/clean.sh"
end
