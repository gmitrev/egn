require 'bundler/gem_tasks'

require 'rake'

require 'coveralls/rake/task'
Coveralls::RakeTask.new
task test_with_coveralls: [:spec, :features, 'coveralls:push']

require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) { |spec| spec.pattern = FileList['spec/**/*_spec.rb'] }

task default: :spec

task :console do
  require 'irb'
  require 'irb/completion'
  require 'egn' # You know what to do.
  ARGV.clear
  IRB.start
end
