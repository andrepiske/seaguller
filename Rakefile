require 'rubygems'
require 'rake/testtask'

task default: ['test']

Rake::TestTask.new do |test|
  test.libs = ['lib', 'test']
  test.test_files =Rake::FileList['test/**/*_test.rb']
  test.verbose = true
  test.warning = false
end
