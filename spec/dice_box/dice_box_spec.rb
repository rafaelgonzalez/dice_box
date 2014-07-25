describe DiceBox::Dice do
  subject { described_class.new(4) }

  describe '#sides' do
    it 'returns an Array of Sides' do
      expect(subject.sides).to be_a(Array)

      subject.sides.each do |side|
        expect(side).to be_a(DiceBox::Dice::Side)
      end
    end

    it 'has the correct number of sides' do
      expect(subject.sides.length).to eql 4
    end
  end

  describe '#current_side' do
    context 'with a non-rolled Dice' do
      it 'returns nil' do
        expect(subject.current_side).to be_nil
      end
    end

    context 'with a rolled Dice' do
      it 'returns the last rolled side' do
        rolled_value = subject.roll

        expect(subject.current_side.value).to eql rolled_value
      end
    end
  end

  describe '.roll' do
    context 'with 1 dice of 6 sides' do
      it 'is always superior to 0' do
        expect(described_class.roll(6, 1)).to be > 0
      end

      it 'is always inferior to 7' do
        expect(described_class.roll(6, 1)).to be < 7
      end
    end

    context 'with 5 dices of 3 sides' do
      it 'is always superior to 5' do
        expect(described_class.roll(3, 5)).to be > 5
      end

      it 'is always inferior to 16' do
        expect(described_class.roll(3, 5)).to be < 16
      end
    end

    context 'with 0 dice' do
      it 'returns 0' do
        expect(described_class.roll(6, 0)).to eql 0
      end
    end

    context 'with a negative amount of dices' do
      it 'returns 0' do
        expect(described_class.roll(6, -1)).to eql 0
      end
    end
  end

  describe '#roll' do
    context 'with a dice of 6 sides' do
      subject { described_class.new(6) }

      it 'is always superior to 0' do
        expect(subject.roll).to be > 0
      end

      it 'is always inferior to 7' do
        expect(subject.roll).to be < 7
      end
    end

    it 'sets #current_side to ' do
      rolled_value = subject.roll

      expect(subject.current_side.value).to eql rolled_value
    end
  end
end
