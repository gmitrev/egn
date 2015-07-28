require 'date'

require 'egn/egn'
require 'egn/parser'
require 'egn/validator'
require 'egn/generator'
require 'egn/version'
require 'egn/util'

module Egn
  # Quick generate: returns a new number
  def self.generate(options = {})
    Generator.generate(options)
  end

  # Quick validate
  def self.validate(egn)
    Validator.validate(egn)
  end

  # Quick parse
  def self.parse(egn)
    Egn.new(egn)
  end
end
