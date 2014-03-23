require 'spec_helper'

describe Egn::Generators::Egn do

  describe "#generate" do
    context "invoked with no arguments" do

      it 'generates a valid number' do
        egn = Egn::Generators::Egn.generate

        expect(egn).not_to be_empty
      end

      it 'returns different number every time' do
        egn1 = Egn::Generators::Egn.generate
        egn2 = Egn::Generators::Egn.generate

        expect(egn1).not_to eq egn2
      end

    end

    context "invoked with arguments" do
      it "generates a new EGN considering the given options" do
        number = Egn::Generators::Egn.generate(year: 1990, month: 12, day: 30, sex: :m)
        egn = Egn::Egn.new(number)

        expect(egn).to be_valid
      end

      it "generates a new EGN with the given year" do
        number = Egn::Generators::Egn.generate(year: 1990)
        egn = Egn::Egn.new(number)

        expect(egn.year).to eq(1990)
      end

      it "generates a new EGN with the given month" do
        number = Egn::Generators::Egn.generate(month: 6)
        egn = Egn::Egn.new(number)

        expect(egn.month).to eq(6)
      end

      it "generates a new EGN with the given day" do
        number = Egn::Generators::Egn.generate(day: 15)
        egn = Egn::Egn.new(number)

        expect(egn.day).to eq(15)
      end

    end
  end
end

