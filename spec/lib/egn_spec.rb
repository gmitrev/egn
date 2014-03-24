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

        Egn::Generators::Egn.should_receive(:generate)

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

        Egn::Generators::Egn.should_receive(:generate).with(options)

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
      Egn::Validators::Egn.should_receive(:validate).with(egn.number)
      egn.valid?
    end
  end


  describe 'validating'

  describe 'parsing'

end

