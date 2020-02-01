# frozen_string_literal: true

require 'simplecov'
require 'minitest/autorun'
require 'zip/bzip2'

if defined? JRUBY_VERSION
  require 'jruby'
  JRuby.objectspace = true
end
