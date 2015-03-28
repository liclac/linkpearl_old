# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

task :promote, [:email] => :environment do |t, args|
  User.find_by(email: args[:email]).update_attribute('admin', true)
end
