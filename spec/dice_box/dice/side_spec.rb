describe DiceBox::Dice::Side do
  let(:dice) { described_class.new(12) }

  describe '#value' do
    subject { dice.value }

    it { is_expected.to eql 12 }
  end

  describe '#weight' do
    subject { dice.weight }

    it { is_expected.to eql 1.0 }
  end
end
