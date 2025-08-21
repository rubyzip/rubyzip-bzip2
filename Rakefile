# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'minitest/test_task'
require 'rubocop/rake_task'

task default: :test

Minitest::TestTask.create do |test|
  test.framework = 'require "simplecov"'
  test.test_globs = 'test/**/*_test.rb'
end

RuboCop::RakeTask.new
