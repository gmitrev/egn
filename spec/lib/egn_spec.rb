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

    context "inoked with an options hash" do

      it "generates a new EGN considering the given options" do
        egn = Egn::Egn.new(year: 1990, month: 12, day: 30, sex: :male)

        expect(egn).to be_valid
      end

      it "generates a new EGN with the given year" do
        egn = Egn::Egn.new(year: 1990)

        expect(egn.year).to eq(1990)
      end


    end
  end

  describe 'validating'

  describe 'parsing'

end

