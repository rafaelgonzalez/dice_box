require 'simplecov'
require 'codeclimate-test-reporter'

SimpleCov.start do
  add_filter '/spec/'
end

SimpleCov.minimum_coverage 100

CodeClimate::TestReporter.start

require 'dice_box'

RSpec.configure do
end
