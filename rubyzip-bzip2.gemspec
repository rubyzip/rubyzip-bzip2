# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zip/bzip2/version'

Gem::Specification.new do |spec|
  spec.name = 'rubyzip-bzip2'
  spec.version = ::Zip::Bzip2::VERSION
  spec.authors = [
    'Jan-Joost Spanjers',
  ]

  spec.summary = 'Extension of rubyzip to read bzip2 compressed files'
  spec.description =
    'The rubyzip-bzip2 gem provides an extension of the rubyzip gem '\
    'for reading zip files compressed with bzip2 compression'
  spec.homepage = 'http://github.com/rubyzip/rubyzip-bzip2'
  spec.license = 'BSD 2-Clause'

  spec.required_ruby_version = '>= 2.4'

  spec.metadata = {
    'bug_tracker_uri' => 'https://github.com/rubyzip/rubyzip-bzip2/issues',
    'changelog_uri' => "https://github.com/rubyzip/rubyzip-bzip2/blob/v#{spec.version}/Changelog.md",
    'documentation_uri' => "https://www.rubydoc.info/gems/rubyzip-bzip2/#{spec.version}",
    'source_code_uri' => "https://github.com/rubyzip/rubyzip-bzip2/tree/v#{spec.version}",
    'wiki_uri' => 'https://github.com/rubyzip/rubyzip-bzip2/wiki',
  }

  spec.files = Dir.glob('{lib}/**/*.rb') + %w[README.md]

  spec.add_dependency 'ffi', '~> 1.0'
  spec.add_dependency 'rubyzip', '~> 2.2'

  spec.add_development_dependency 'coveralls', '~> 0.7'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-minitest'
  spec.add_development_dependency 'minitest', '~> 5.4'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rake', '~> 10.3'
  spec.add_development_dependency 'rubocop', '~> 0.79.0'
end
