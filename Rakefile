# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

require 'rubygems'
require 'rake'
require 'coveralls/rake/task'


begin
  require 'rspec/core/rake_task'
  desc 'Run all examples'
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = %w[--color]
    t.pattern = 'spec/**/*_spec.rb'
  end
rescue LoadError
end

task default: :spec

Coveralls::RakeTask.new
