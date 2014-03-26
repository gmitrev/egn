require "date"

require "egn/egn"
require "egn/parser"
require "egn/validator"
require "egn/generator"
require "egn/version"

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

  def self.determine_date(year, month)
      case month
      when (1..12)
        year = "19#{year}"
      when (21..32)
        month -= 20
        year = "18#{year}"
      when (41..52)
        month -= 40
        year = "20#{year}"
      end

      [year.to_i, month]
  end

end
