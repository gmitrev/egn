# Egn

EGN(ЕГН) is the national identification number of Bulgarian citizens. This gem 
provides ways to generate, validate and parse any given valid number for
information.

## Installation

Add this line to your application's Gemfile:

    gem 'egn'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install egn

## Usage

    require "egn"

    # Generate a random number
    Egn.generate
    # => "6101047500"
    
    # Validate a given number
    Egn.validate("6101047500")
    # => true
    
    # Parse a given number 
    egn = Egn.parse("6101047500")
    # => #<Egn::Parser:0x93d9074 @year=1961, @month=1, @day=4>
    
    egn.birth_date
    # => #<Date: 1961-01-04 ((2437304j,0s,0n),+0s,2299161j)>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
