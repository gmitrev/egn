require 'spec_helper'

describe "Egn" do

  describe '.initialize' do

    context "invoked with no args" do

      it 'generates a valid number' do
        egn = Egn::Egn.new

        expect(egn).to be_valid
      end

      it 'returns different number every time' do
        egn1 = Egn::Egn.new
        egn2 = Egn::Egn.new

        expect(egn1.number).not_to eq egn2.number
      end

      it "delegates the creation to Generators::Egn" do

        Egn::Generator.should_receive(:generate).and_return "6101047500"

        Egn::Egn.new
      end

    end

    context "invoked with an EGN " do

      it "returns a new Egn object if the provided EGN is valid" do
        egn = Egn::Egn.new('6101047500')

        expect(egn).to be_valid
      end

      it "raises an ArgumentError if the provided EGN is not valid" do
        expect{
          Egn::Egn.new("I'm invalid")
        }.to raise_error ArgumentError
      end

    end

    context "invoked with an options hash" do

      it "passes the options to the #generate method" do
        options = {
          year: 1960,
          month: 12
        }

        Egn::Generator.should_receive(:generate).with(options).and_return('6012081988')

        Egn::Egn.new(options)
      end

    end

    context "invoked with something else" do
      it 'raises an ArgumentError' do
        expect{
          Egn::Egn.new([1,2,'hi'])
        }.to raise_error ArgumentError
      end
    end
  end

  describe "valid?" do
    it 'delegates the validation to Validators::Egn' do
      egn = Egn::Egn.new
      Egn::Validator.should_receive(:validate).with(egn.number)
      egn.valid?
    end
  end


  describe 'validating'

  describe 'parsing'

  describe 'sex' do

    # Female
    %w(4702054631 5202079211 8012304154 9506062719 9308110830).each do |female_egn|
      it "works for female with egn #{female_egn}" do
        egn = Egn::Egn.new(female_egn)
        expect(egn.sex).to eq :female
      end
    end

    # Male
    %w(0612318303 4310093863 4903195863 6109226225 9805316300).each do |male_egn|
      it "works for male with egn #{male_egn}" do
        egn = Egn::Egn.new(male_egn)
        expect(egn.sex).to eq :male
      end
    end

    it 'allows an option to be passed that changes the output to numbers' do
      male   = Egn.parse("0612318303")
      female = Egn.parse("5202079211")

      expect(male.sex(format: :number)).to eq 1
      expect(female.sex(format: :number)).to eq 2
    end

    it 'allows an option to be passed that changes the output to a single char' do
      male   = Egn.parse("0612318303")
      female = Egn.parse("5202079211")

      expect(male.sex(format: :char)).to eq 'm'
      expect(female.sex(format: :char)).to eq 'f'
    end

  end

end

