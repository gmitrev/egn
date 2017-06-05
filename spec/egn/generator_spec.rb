require 'spec_helper'

describe Egn::Generator do
  describe '#generate' do
    context 'invoked with no arguments' do
      it 'generates a valid number' do
        egn = Egn::Generator.generate

        expect(egn).not_to be_empty
      end

      it 'returns different number every time' do
        egn1 = Egn::Generator.generate
        egn2 = Egn::Generator.generate

        expect(egn1).not_to eq egn2
      end
    end

    context 'invoked with arguments' do
      it 'generates a new EGN considering the given options' do
        number = Egn::Generator.generate(year: 1990, month: 12, day: 30, gender: :male)
        egn = Egn::Egn.new(number)

        expect(egn).to be_valid
      end

      it 'generates a new EGN with the given year' do
        number = Egn::Generator.generate(year: 1990)
        egn = Egn::Egn.new(number)

        expect(egn.year).to eq(1990)
      end

      it 'generates a new EGN with the given month' do
        number = Egn::Generator.generate(month: 6)
        egn = Egn::Egn.new(number)

        expect(egn.month).to eq(6)
      end

      it 'generates a new EGN with the given day' do
        number = Egn::Generator.generate(day: 29)
        egn = Egn::Egn.new(number)

        expect(egn.day).to eq(29)
      end

      it "doesn't generate invalid EGN's for day 29 (in case of february)" do
        Array.new(10_000) { |_i| Egn.generate(day: 29) }.each do |egn|
          result = Egn::Validator.validate(egn)
          expect(result).to be_truthy, "Failed for #{egn}"
        end
      end

      it 'generates female EGNs' do
        number = Egn::Generator.generate(gender: :female)
        egn = Egn::Egn.new(number)

        expect(egn.gender).to eq(:female)
      end

      it 'generates male EGNs' do
        number = Egn::Generator.generate(gender: :male)
        egn = Egn::Egn.new(number)

        expect(egn.gender).to eq(:male)
      end

      it 'validates the options' do
        options = { year: 1960, month: 6, day: 3, gender: :male, region: 333 }

        Egn::Generator.any_instance.should_receive(:validate!)

        Egn::Generator.generate(options)
      end
    end
  end

  describe '#validate!' do
    it 'raises an exception if invalid year is given' do
      expect do
        Egn::Generator.generate(year: 1500)
      end.to raise_error ArgumentError
    end

    it 'raises an exception if invalid month is given' do
      expect do
        Egn::Generator.generate(month: 15)
      end.to raise_error ArgumentError
    end

    it 'raises an exception if invalid day is given' do
      expect do
        Egn::Generator.generate(day: 33)
      end.to raise_error ArgumentError
    end

    it 'raises an exception if invalid gender is given' do
      expect do
        Egn::Generator.generate(gender: :none)
      end.to raise_error ArgumentError
    end
  end
end
