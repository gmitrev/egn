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
  end

  describe 'generating' do

    it 'creates a new'

  end

  describe 'validating'

  describe 'parsing'

end

