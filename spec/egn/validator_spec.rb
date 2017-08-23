require 'spec_helper'

describe Egn::Validator do
  describe '#validate' do
    it 'fails for strings with incorrect size' do
      expect(Egn::Validator.validate('123456789')).to be_falsey
      expect(Egn::Validator.validate('12345678901')).to be_falsey
    end

    it 'fails for incorrect dates' do
      expect(Egn::Validator.validate('6101347500')).to be_falsey
    end

    it 'fails if year is out of range' do
      expect(Egn::Util.year_in_range?(1990)).to be_truthy
      expect(Egn::Util.year_in_range?(201)).to be_falsey
    end

    it 'checks 10 000 of the generated numbers' do
      Array.new(10_000) { |_| Egn.generate }.each do |egn|
        result = Egn::Validator.validate(egn)
        expect(result).to be_truthy, "Failed for #{egn}"
      end
    end
  end
end
