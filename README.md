[![Build Status](https://travis-ci.org/gmitrev/egn.svg?branch=master)](https://travis-ci.org/gmitrev/egn)
[![Coverage Status](https://coveralls.io/repos/gmitrev/egn/badge.png?branch=master)](https://coveralls.io/r/gmitrev/egn?branch=master)
[![Code Climate](https://codeclimate.com/github/gmitrev/egn.png)](https://codeclimate.com/github/gmitrev/egn)
# Egn

EGN(ЕГН) is the national identification number of Bulgarian citizens. This gem
provides ways to generate, validate and parse any given valid number for
information.

## Installation

Add this line to your application's Gemfile:
```ruby
gem 'egn'
```
And then execute:

    $ bundle

Or install it yourself as:

    $ gem install egn

## Usage

```ruby
require 'egn'

# Quickly generate a random number
Egn.generate
=> '6101047500'

# Validate a given number
Egn.validate('6101047500')
=> true

# Create an new EGN object with a random number
egn = Egn::Egn.new
=> 9212094524

# OR generate EGN for a specific date
egn = Egn::Egn.new(year: 1945, month: 5, day: 8)
=> 4505085346

# OR parse an existing one
egn = Egn.parse('6101047500')
=> 6101047500

egn.birth_date
=> #<Date: 1961-01-04 ((2437304j,0s,0n),+0s,2299161j)>

egn.year
=> 1961

egn.month
=> 1

egn.day
=> 10

egn.gender # egn.sex can also be used
=> :male

egn.gender(format: :char)
=> 'm'

egn.gender(format: :number)
=> 1

egn.age
=> 58

egn.valid?
=> true
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
