Linkpearl
=========

Description should probably go here, bla bla, I'm tired.

Requirements
------------

* [Vagrant](http://vagrantup.com)
* [VirtualBox](https://virtualbox.org), or VMware [Fusion](http://vmware.com/products/fusion/) (mac) / [Workstation](http://vmware.com/products/workstation/) (windows, linux) + [this plugin](http://www.vagrantup.com/vmware)

Installation
------------

Create the virtual machine:

    vagrant up
    # this can take a while...
    vagrant ssh
    cd /vagrant

Set up the application:

    bundle install
    rake db:migrate

Run a development server, complete with a task queue, etc:

    bundle exec foreman start

Access it at <http://localhost:5000>, and register an account.  
Then promote yourself to admin:

    rake 'promote[youremail@example.com]'

Upgrading
---------

    vagrant provision
    vagrant ssh
    
    cd /vagrant
    bundle install
    rake db:migrate
