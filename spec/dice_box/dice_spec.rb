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

  describe '#rolled_side' do
    context 'with a non-rolled Dice' do
      it 'returns nil' do
        expect(subject.rolled_side).to be_nil
      end
    end

    context 'with a rolled Dice' do
      it 'returns the last rolled side' do
        rolled_value = subject.roll

        expect(subject.rolled_side.value).to eql rolled_value
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
        expect(described_class.roll(3, 5)).to be > 4
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
    it 'sets #rolled_side to the rolled value' do
      rolled_value = subject.roll

      expect(subject.rolled_side.value).to eql rolled_value
    end

    context 'with a dice of 6 sides' do
      subject { described_class.new(6) }

      it 'is always superior to 0' do
        expect(subject.roll).to be > 0
      end

      it 'is always inferior to 7' do
        expect(subject.roll).to be < 7
      end
    end

    context 'with a crooked dice' do
      subject { described_class.new(3) }

      before do
        subject.sides[0].weight = 0
        subject.sides[1].weight = 0
      end

      it 'rolls the side with weight' do
        expect(subject.roll).to eql 3
      end
    end
  end

  describe '#rolled' do
    context 'with a non-rolled Dice' do
      it 'returns nil' do
        expect(subject.rolled).to be_nil
      end
    end

    context 'with a rolled Dice' do
      it 'returns the last rolled side' do
        rolled_value = subject.roll

        expect(subject.rolled).to eql rolled_value
      end
    end
  end

  describe '#balanced?' do
    context 'with Sides of the same weight' do
      it 'returns true' do
        expect(subject).to be_balanced
      end
    end

    context 'with Sides with different weight' do
      before { subject.sides.first.weight = 2.0 }

      it 'returns false' do
        expect(subject).not_to be_balanced
      end
    end
  end

  describe '#crooked?' do
    context 'with Sides of the same weight' do
      it 'returns false' do
        expect(subject).not_to be_crooked
      end
    end

    context 'with Sides with different weight' do
      before { subject.sides.first.weight = 2.0 }

      it 'returns true' do
        expect(subject).to be_crooked
      end
    end
  end

  describe '#weight' do
    subject { described_class.new(4) }

    before do
      subject.sides[0].weight = 2.32
      subject.sides[1].weight = 3.0
      subject.sides[2].weight = 1.26
      subject.sides[3].weight = 0.72
    end

    it 'returns the total of Sides weights' do
      expect(subject.weight).to eql 7.3
    end
  end
end
