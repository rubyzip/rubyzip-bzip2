# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zip/bzip2/version'

Gem::Specification.new do |spec|
  spec.name = 'rubyzip-bzip2'
  spec.version = ::Zip::Bzip2::VERSION
  spec.authors = [
    'Jan-Joost Spanjers', 'Robert Haines'
  ]

  spec.summary = 'Extension of rubyzip to read bzip2 compressed files'
  spec.description =
    'The rubyzip-bzip2 gem provides an extension of the rubyzip gem '\
    'for reading zip files compressed with bzip2 compression'
  spec.homepage = 'http://github.com/rubyzip/rubyzip-bzip2'
  spec.license = 'BSD 2-Clause'
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 3.0'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.metadata = {
    'bug_tracker_uri' => 'https://github.com/rubyzip/rubyzip-bzip2/issues',
    'changelog_uri' => "https://github.com/rubyzip/rubyzip-bzip2/blob/v#{spec.version}/Changelog.md",
    'documentation_uri' => "https://www.rubydoc.info/gems/rubyzip-bzip2/#{spec.version}",
    'source_code_uri' => "https://github.com/rubyzip/rubyzip-bzip2/tree/v#{spec.version}",
    'wiki_uri' => 'https://github.com/rubyzip/rubyzip-bzip2/wiki',
    'rubygems_mfa_required' => 'true'
  }

  spec.add_dependency 'ffi', '~> 1.0'
  spec.add_dependency 'rubyzip', '~> 3.0.0.rc2'

  spec.add_development_dependency 'minitest', '~> 5.15'
  spec.add_development_dependency 'rake', '~> 13.2'
  spec.add_development_dependency 'rubocop', '~> 1.61.0'
  spec.add_development_dependency 'rubocop-performance', '~> 1.20.0'
  spec.add_development_dependency 'rubocop-rake', '~> 0.6.0'
  spec.add_development_dependency 'simplecov', '~> 0.18.0'
  spec.add_development_dependency 'simplecov-lcov', '~> 0.8'
end
