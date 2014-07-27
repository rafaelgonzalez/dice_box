require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec')

task :default => :test

desc 'Run the test suite'
task :test => :spec

begin
  require 'cane/rake_task'

  desc "Run Cane to check quality metrics"
  Cane::RakeTask.new(:quality) do |cane|
    cane.canefile = '.cane'
  end
rescue LoadError
  warn "Cane not available, :quality task not provided."
end

Rake::Task[:test].enhance do
  Rake::Task[:quality].invoke
end
