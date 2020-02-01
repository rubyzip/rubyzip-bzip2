# frozen_string_literal: true

guard :minitest do
  # with Minitest::Unit
  watch(%r{^test/(.*)\/?(.*)_test\.rb$})
  watch(%r{^lib/zip/bzip2/(.*/)?([^/]+)\.rb$}) { |m| "test/models/zip/bzip2/#{m[1]}#{m[2]}_test.rb" }
  watch(%r{^test/test_helper\.rb$}) { 'test' }
end
