require "date"

require "egn/egn"

require "egn/generators/egn"
require "egn/parser"
require "egn/validator"
require "egn/version"

module Egn

  def self.generate
    Egn::Generator::Egn.generate
  end

  def self.validate(egn)
    Validator.egn(egn)
  end

  def self.parse(egn)
    Parser.new(egn)
  end

end
