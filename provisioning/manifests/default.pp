# APT stop being dumb
class { 'apt': }

# Essential system software
package { 'build-essential': ensure => present }

# Useful stuff I like to have around
package { 'vim': ensure => present }
package { 'tmux': ensure => present }
package { 'htop': ensure => present }

# Git
class { 'git': }

# Install Redis
package { 'redis-server': ensure => present }

# Install and configure PostgreSQL
class { 'postgresql::server': }
package { 'postgresql-server-dev-all': ensure => present }

# Create the linkpearl database
postgresql::server::db { 'linkpearl':
    user => 'linkpearl',
    password => 'linkpearl',
}

# Let the vagrant user access the linkpearl db
# This lets runserver work without passwords involved
postgresql::server::role { 'vagrant': superuser => true }
postgresql::server::database_grant { 'vagrant':
  privilege => 'ALL',
  db => 'linkpearl',
  role => 'vagrant',
}

# Install Ruby and gem build dependencies
package { 'libssl-dev': ensure => present }
package { 'libsqlite3-dev': ensure => present }

class { 'rbenv': }
rbenv::plugin { 'sstephenson/ruby-build': }
rbenv::build { '2.2.0': global => true }
