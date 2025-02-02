# rubyzip-bzip2

[![Gem Version](https://badge.fury.io/rb/rubyzip-bzip2.svg)](http://badge.fury.io/rb/rubyzip-bzip2)
[![Tests](https://github.com/rubyzip/rubyzip-bzip2/actions/workflows/tests.yml/badge.svg)](https://github.com/rubyzip/rubyzip-bzip2/actions/workflows/tests.yml)
[![Linter](https://github.com/rubyzip/rubyzip-bzip2/actions/workflows/lint.yml/badge.svg)](https://github.com/rubyzip/rubyzip-bzip2/actions/workflows/lint.yml)
[![Code Climate](https://codeclimate.com/github/rubyzip/rubyzip-bzip2.svg)](https://codeclimate.com/github/rubyzip/rubyzip-bzip2)
[![Coverage Status](https://img.shields.io/coveralls/rubyzip/rubyzip-bzip2.svg)](https://coveralls.io/r/rubyzip/rubyzip-bzip2?branch=master)

The rubyzip-bzip2 gem provides an extension of the rubyzip gem for reading zip files compressed with bzip2 compression.

## Website and Project Home
http://github.com/rubyzip/rubyzip-bzip2

## Requirements
- Ruby 2.4 or greater

## Installation
The rubyzip-bzip2 gem is available on RubyGems:

```
gem install rubyzip-bzip2
```

Or in your Gemfile:

```ruby
gem 'rubyzip-bzip2'
```

## Usage
Reading a zip file with bzip2 compression is not different from reading
any other zip file using rubyzip:

```ruby
require 'zip/bzip2'

Zip::File.open('foo.zip') do |zipfile|
  zipfile.each do |entry|
    content = zipfile.read(entry.name)
  end
end

```

## License
Rubyzip-bzip2 is distributed under the same license as Ruby. In practice this means you can use it under the terms of the Ruby License or the 2-Clause BSD License. See https://www.ruby-lang.org/en/about/license.txt and LICENSE.md for details.

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/rubyzip/rubyzip-bzip2.

## Development
You can run the tests with:

```
bundle install
rake
```

## Authors

See https://github.com/rubyzip/rubyzip-bzip2/graphs/contributors for a comprehensive list.

### Current maintainers

* Robert Haines (@hainesr)
* John Lees-Miller (@jdleesmiller)
* Oleksandr Simonov (@simonoff)

### Original author
Jan-Joost Spanjers ( oss at hiberis.nl )
