Dir.glob('.rake/*.rake').each { |r| import r }

require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
end

desc 'Load the database and run features'
task :cukes do
  Rake::Task["clean"].invoke
  Rake::Task["reset_db"].invoke
  Rake::Task["load_db"].invoke
  Rake::Task["features"].invoke
end

RSpec::Core::RakeTask.new(:spec)

desc 'Reset the database and run specs'
task :clean_and_run_specs do
  Rake::Task["clean"].invoke
  Rake::Task["reset_db"].invoke
  Rake::Task["spec"].invoke
end

task :clean do
  $config = YAML.load_file("./config/config.yml")
  logfile = $config[ENV['RACK_ENV']]['logger']
  rm logfile if File.exist? logfile
  mkdir_p 'logs'
  touch logfile
end

task :reset_db do
ruby 'util/db_init.rb'
end

task :load_db do
  ruby 'util/db_load.rb'
end

task :default => :clean_and_run_specs
