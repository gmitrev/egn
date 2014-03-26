require 'bundler/setup'
Bundler.setup

require 'egn'

require 'coveralls'
Coveralls.wear!

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.filter_run_excluding :brute


  config.order = 'random'
end
