require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new

task default: :test

desc 'Run the test suite'
task test: [:spec, :rubocop]

begin
  require 'cane/rake_task'

  desc 'Run Cane to check quality metrics'
  Cane::RakeTask.new(:quality) do |cane|
    cane.canefile = '.cane'
  end

  Rake::Task[:test].enhance do
    Rake::Task[:quality].invoke
  end
rescue LoadError
  warn 'Cane not available, :quality task not provided.'
end

RuboCop::RakeTask.new(:rubocop) do |task|
  task.options = ['-D']
end
