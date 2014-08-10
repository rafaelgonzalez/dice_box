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

  context '.roll_with_notation' do
    context "passing 'D6'" do
      let(:notation) { 'D6' }

      it 'calls .roll with the correct arguments' do
        expect(described_class).to receive(:roll).with(6, 1).once
        described_class.roll_with_notation(notation)
      end
    end

    context "passing '1d6'" do
      let(:notation) { '1d6' }

      it 'calls .roll with the correct arguments' do
        expect(described_class).to receive(:roll).with(6, 1).once
        described_class.roll_with_notation(notation)
      end
    end

    context "passing '4d20'" do
      let(:notation) { '4d20' }

      it 'calls .roll with the correct arguments' do
        expect(described_class).to receive(:roll).with(20, 4).once
        described_class.roll_with_notation(notation)
      end
    end

    context "passing '2d4+7'" do
      let(:notation) { '2d4+7' }

      it 'adds 7 to the roll result' do
        expect(described_class).to receive(:roll).with(4, 2).once.and_return(3)
        expect(described_class.roll_with_notation(notation)).to eql 10
      end
    end

    context "passing '3d9-4'" do
      let(:notation) { '3d9-4' }

      it 'substracts 4 from the roll result' do
        expect(described_class).to receive(:roll).with(9, 3).once.and_return(11)
        expect(described_class.roll_with_notation(notation)).to eql 7
      end
    end

    context "passing '8d3x5'" do
      let(:notation) { '8d3x5' }

      it 'multiplies the roll result by 5' do
        expect(described_class).to receive(:roll).with(3, 8).once.and_return(27)
        expect(described_class.roll_with_notation(notation)).to eql 135
      end
    end

    context "passing 'd30÷2'" do
      let(:notation) { 'd30÷2' }

      it 'divides the roll result by 2' do
        expect(described_class).to receive(:roll).with(30, 1).once.and_return(16)
        expect(described_class.roll_with_notation(notation)).to eql 8
      end
    end

    context "passing '0d0÷2'" do
      let(:notation) { '0d0÷2' }

      it 'raises an ArgumentError' do
        expect { described_class.roll_with_notation(notation) }.to raise_error(ArgumentError)
      end
    end

    context "passing '4d'" do
      let(:notation) { '4d' }

      it 'raises an ArgumentError' do
        expect { described_class.roll_with_notation(notation) }.to raise_error(ArgumentError)
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

    context 'with a rolled side that changes value' do
      it 'returns the rolled value' do
        rolled_value = subject.roll

        expect(subject.rolled).to eql rolled_value

        subject.rolled_side.value = 1000

        expect(subject.rolled).to eql rolled_value
      end
    end
  end

  describe '#maximum' do
    subject { DiceBox::Dice.new(6) }

    context 'with a classical dice' do
      it 'returns the highest value the dice can roll' do
        expect(subject.maximum).to eql 6
      end
    end

    context 'with a dice with changed side values' do
      before do
        subject.sides[0].value = 247
        subject.sides[1].value = 12
        subject.sides[2].value = 271
        subject.sides[3].value = 9
        subject.sides[4].value = 46
        subject.sides[5].value = 5
      end

      it 'returns the highest value the dice can roll' do
        expect(subject.maximum).to eql 271
      end
    end
  end

  describe '#minimum' do
    subject { DiceBox::Dice.new(6) }

    context 'with a classical dice' do
      it 'returns the lowest value the dice can roll' do
        expect(subject.minimum).to eql 1
      end
    end

    context 'with a dice with changed side values' do
      before do
        subject.sides[0].value = 247
        subject.sides[1].value = 12
        subject.sides[2].value = 271
        subject.sides[3].value = 9
        subject.sides[4].value = 46
        subject.sides[5].value = 5
      end

      it 'returns the lowest value the dice can roll' do
        expect(subject.minimum).to eql 5
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
