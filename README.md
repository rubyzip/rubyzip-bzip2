# rubyzip-bzip2

[![Gem Version](https://badge.fury.io/rb/rubyzip-bzip2.svg)](http://badge.fury.io/rb/rubyzip-bzip2)
[![Build Status](https://secure.travis-ci.org/rubyzip/rubyzip-bzip2.svg)](http://travis-ci.org/rubyzip/rubyzip-bzip2)
[![Code Climate](https://codeclimate.com/github/rubyzip/rubyzip-bzip2.svg)](https://codeclimate.com/github/rubyzip/rubyzip-bzip2)
[![Coverage Status](https://img.shields.io/coveralls/rubyzip/rubyzip-bzip2.svg)](https://coveralls.io/r/rubyzip/rubyzip-bzip2?branch=master)

The rubyzip-bzip2 gem provides an extension of the rubyzip gem for reading zip files
compressed with bzip2 compression.

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
Zip::File.open('foo.zip') do |zipfile|
  zipfile.each do |entry|
    content = zipfile.read(entry.name)
  end
end

```

## License
Rubyzip-bzip2 is distributed under the same license as ruby. See
http://www.ruby-lang.org/en/LICENSE.txt

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/rubyzip/rubyzip-bzip2.

## Development
You can run the tests with:

```
bundle install
rake
```

## Authors
Jan-Joost Spanjers ( oss at hiberis.nl )
