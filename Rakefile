# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Vacaycaster::Application.load_tasks

require 'resque/tasks'
require 'resque/scheduler/tasks'

task "resque:setup" => :environment do
  ENV['QUEUE'] = '*'
end

desc "check for updated calendars"
task "resque:EnqueCalendarGetters" => "resque:setup" do
	Resque.enqueue(EnqueCalendarGetters)
end

