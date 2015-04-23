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
postgresql::server::database { 'linkpearl_development': owner => 'linkpearl' }
postgresql::server::database { 'linkpearl_test': owner => 'linkpearl' }

# Let the vagrant user access the linkpearl db
# This lets runserver work without passwords involved
postgresql::server::role { 'vagrant': superuser => true }
postgresql::server::database_grant { 'vagrant':
  privilege => 'ALL',
  db => 'linkpearl_development',
  role => 'vagrant',
}

# Install NodeJS and npm
apt::source { 'nodesource':
  location => 'https://deb.nodesource.com/node',
  key => '9FD3B784BC1C6FC31A8A0A1C1655A0AB68576280',
}
package { 'nodejs': ensure => present, require => Apt::Source['nodesource'] }
package { 'nodejs-legacy': ensure => present, require => Apt::Source['nodesource'] }
package { 'npm': ensure => present, require => Apt::Source['nodesource'] }

# Install Ruby and gem build dependencies
package { 'libssl-dev': ensure => present }
package { 'libsqlite3-dev': ensure => present }

class { 'rbenv': }
rbenv::plugin { 'sstephenson/ruby-build': }
rbenv::build { '2.2.0': global => true }

# Install Java for ElasticSearch
package { 'openjdk-7-jdk': ensure => present }

# Install ElasticSearch
apt::source { 'elasticsearch':
  location    => 'http://packages.elasticsearch.org/elasticsearch/1.5/debian',
  release     => 'stable',
  key         => '46095ACC8548582C1A2699A9D27D666CD88E42B4',
  key_server  => 'pgp.mit.edu',
  include_src => false,
  include_deb => true,
} ~>
package { 'elasticsearch': ensure => present } ~>
service { 'elasticsearch':
  ensure => running,
  enable => true,
  require => Package['openjdk-7-jdk'],
}
