describe DiceBox::Dice::Side do
  subject { described_class.new(12) }

  describe '#value' do
    it 'returns the value' do
      expect(subject.value).to eql 12
    end
  end

  describe '#weight' do
    it 'returns the value' do
      expect(subject.weight).to eql 1.0
    end
  end
end
