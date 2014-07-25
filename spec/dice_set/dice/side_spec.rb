describe DiceSet::Dice::Side do
  subject { described_class.new(12) }

  describe '#value' do
    it 'returns the value' do
      expect(subject.value).to eql 12
    end
  end
end
