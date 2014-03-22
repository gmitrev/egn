require "date"

require "egn/egn"

require "egn/generator"
require "egn/parser"
require "egn/validator"
require "egn/version"

module Egn

  def self.generate
    Generator.egn
  end

  def self.validate(egn)
    Validator.egn(egn)
  end

  def self.parse(egn)
    Parser.new(egn)
  end

end
