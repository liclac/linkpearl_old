# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

task :promote, [:email] => :environment do |t, args|
  User.find_by(email: args[:email]).update_attribute('admin', true)
end

task :import, [:lid] => :environment do |t, args|
  c = Character.new
  c.lodestone_id = args[:lid]
  c.lodestone_update
  c.save
end
