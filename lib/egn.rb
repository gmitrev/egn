require "date"

require "egn/egn"
require "egn/parser"
require "egn/validator"
require "egn/generator"
require "egn/version"
require "egn/util"

module Egn

  def self.generate
    Generator.generate
  end

  def self.validate(egn)
    Validator.validate(egn)
  end

  def self.parse(egn)
    Egn.new(egn)
  end

end
