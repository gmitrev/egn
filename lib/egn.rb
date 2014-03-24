require "date"

require "egn/egn"

require "egn/generators/egn"
require "egn/parsers/egn"
require "egn/validators/egn"
require "egn/version"

module Egn

  def self.generate
    Egn::Generators::Egn.generate
  end

  def self.validate(egn)
    Egn::Validators::Egn.validate(egn)
  end

  def self.parse(egn)
    Egn::Egn.new(egn)
  end

end
