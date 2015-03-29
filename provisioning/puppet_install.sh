#!/bin/bash

# Update the apt-get cache on first run
apt-get update -qq

# Silence the annoying deprecation warning about templatedir
sed -i 's/^templatedir/#templatedir/' /etc/puppet/puppet.conf

# Install Puppet modules
puppet module install puppetlabs-apt
puppet module install puppetlabs-git
puppet module install puppetlabs-postgresql
# puppet module install puppetlabs-ruby
# puppet module install alup-rbenv
puppet module install jdowning-rbenv
