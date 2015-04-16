# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# Sync outdated profiles at 03:10 and 15:10, to match up with the Lodestone's
# updates at 0:00 and 12:00 (03:00 and 15:00 UTC), covering for any delayed
# lodestone updates; the most delayed ones have been ~6min
every '10 3,15 * * *' do
  runner "QueueUpdatesJob.perform_later('character')"
end

# Check for new achievements once every 45 minutes; the schedule for
# these updates on the Lodestone seems completely sporadic, so we can't
# line it up any more accurately than this
every :hour do
  runner "QueueUpdatesJob.perform_later('character', 'achievements')"
end
