require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
task :default => :spec do |t|
end

namespace :features do
  Cucumber::Rake::Task.new(:non_js) do |t|
    t.profile = "webrat"
  end

  Cucumber::Rake::Task.new(:selenium) do |t|
    t.profile = "selenium"
  end
end
