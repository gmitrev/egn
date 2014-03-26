require 'spec_helper'

describe Egn::Parser do

  describe "#initialize" do
    it "raises an exception if the argument is invalid" do
      expect{ Egn::Parser.new("12345678") }.to raise_error ArgumentError
    end
  end

end

