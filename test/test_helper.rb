require 'simplecov'

if ENV['CIRCLE_ARTIFACTS']
  dir = File.join(ENV['CIRCLE_ARTIFACTS'], 'coverage')
  SimpleCov.coverage_dir(dir)
end

SimpleCov.start

if ENV['CIRCLE_ARTIFACTS']
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require 'seaguller'
require 'minitest'
require 'minitest/autorun'
require 'rr'

class Seaguller::Test < ::Minitest::Test
  def fixtures_path
    File.absolute_path("#{__FILE__}/../fixtures")
  end
end
