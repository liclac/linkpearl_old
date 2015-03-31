app_path = File.expand_path(File.dirname(__FILE__) + '/..')
app_env = ENV['RAILS_ENV']

# Stand in the right place
working_directory app_path

# Worker settings
worker_processes 2
timeout 60

# Paths, ho
pid app_path + '/tmp/unicorn.pid'
stderr_path app_path + '/log/unicorn.log'
stdout_path app_path + '/log/unicorn.log'

# Always listen on a socket file
listen app_path + '/tmp/unicorn.sock', backlog: 64

# Listen on Port 3000 in development
listen(3000, backlog: 64) if app_env == 'development'

# Preload the app on startup
preload_app true

# Garbage collection settings.
GC.respond_to?(:copy_on_write_friendly=) &&
  GC.copy_on_write_friendly = true

# Disconnect from the database before forking
before_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!
end

# Reconnect again after forking
after_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.establish_connection
end
