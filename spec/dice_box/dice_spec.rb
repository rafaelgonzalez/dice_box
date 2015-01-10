describe DiceBox::Dice do
  let(:dice) { described_class.new(dice_sides) }
  let(:dice_sides) { 6 }

  describe '#sides' do
    subject { dice.sides }

    it 'returns an Array of Sides' do
      is_expected.to be_a(Array)

      dice.sides.each do |side|
        expect(side).to be_a DiceBox::Dice::Side
      end
    end

    it 'has the correct number of sides' do
      expect(dice.sides.size).to eql 6
    end
  end

  describe '#rolled_side' do
    subject { dice.rolled_side }

    context 'with a non-rolled Dice' do
      it 'returns nil' do
        is_expected.to be_nil
      end
    end

    context 'with a rolled Dice' do
      it 'returns the last rolled side' do
        rolled_value = dice.roll

        is_expected.to be_a DiceBox::Dice::Side
        expect(subject.value).to eql rolled_value
      end
    end
  end

  describe '.roll' do
    subject { described_class.roll(sides, dices) }

    context 'with 1 dice of 6 sides' do
      let(:sides) { 6 }
      let(:dices) { 1 }

      it 'is always superior to 0' do
        is_expected.to be > 0
      end

      it 'is always inferior to 7' do
        is_expected.to be <= 6
      end
    end

    context 'with 5 dices of 3 sides' do
      let(:sides) { 3 }
      let(:dices) { 5 }

      it 'is always superior to 5' do
        is_expected.to be > 4
      end

      it 'is always inferior to 16' do
        is_expected.to be <= 15
      end
    end

    context 'with 0 dice' do
      let(:sides) { 6 }
      let(:dices) { 0 }

      it 'returns 0' do
        is_expected.to eql 0
      end
    end

    context 'with a negative amount of dices' do
      let(:sides) { 6 }
      let(:dices) { -1 }

      it 'returns 0' do
        is_expected.to eql 0
      end
    end
  end

  describe '#roll' do
    subject { dice.roll }

    it 'sets #rolled_side to the rolled value' do
      rolled_value = subject

      expect(dice.rolled_side.value).to eql rolled_value
    end

    context 'with a dice of 4 sides' do
      let(:dice_sides) { 4 }

      it 'is always superior to 0' do
        is_expected.to be > 0
      end

      it 'is always inferior to 7' do
        is_expected.to be <= 4
      end
    end

    context 'with a crooked dice' do
      let(:dice_sides) { 3 }

      before do
        dice.sides[0].weight = 0
        dice.sides[1].weight = 0
      end

      it 'rolls the side with weight' do
        is_expected.to eql 3
      end
    end
  end

  describe '#rolled' do
    subject { dice.rolled }

    context 'with a non-rolled Dice' do
      it { is_expected.to be_nil }
    end

    context 'with a rolled Dice' do
      it 'returns the last rolled side' do
        rolled_value = dice.roll

        is_expected.to eql rolled_value
      end
    end

    context 'with a rolled side that changes value' do
      it 'returns the rolled value' do
        rolled_value = dice.roll

        is_expected.to eql rolled_value

        dice.rolled_side.value = 1000

        is_expected.to eql rolled_value
      end
    end

    it 'has alias methods' do
      expect(dice.method(:rolled)).to eql dice.method(:result)
      expect(dice.method(:rolled)).to eql dice.method(:rolled_value)
    end
  end

  describe '#maximum' do
    subject { dice.maximum }

    context 'with a classical dice' do
      it { is_expected.to eql 6 }
    end

    context 'with a dice with changed side values' do
      before do
        dice.sides[0].value = 247
        dice.sides[1].value = 12
        dice.sides[2].value = 271
        dice.sides[3].value = 9
        dice.sides[4].value = 46
        dice.sides[5].value = 5
      end

      it { is_expected.to eql 271 }
    end

    it 'has alias methods' do
      expect(dice.method(:maximum)).to eql dice.method(:max)
    end
  end

  describe '#minimum' do
    subject { dice.minimum }

    context 'with a classical dice' do
      it { is_expected.to eql 1 }
    end

    context 'with a dice with changed side values' do
      before do
        dice.sides[0].value = 247
        dice.sides[1].value = 12
        dice.sides[2].value = 271
        dice.sides[3].value = 9
        dice.sides[4].value = 46
        dice.sides[5].value = 5
      end

      it { is_expected.to eql 5 }
    end

    it 'has alias methods' do
      expect(dice.method(:minimum)).to eql dice.method(:min)
    end
  end

  describe '#fair?' do
    subject { dice.fair? }

    context 'with Sides of the same weight' do
      it { is_expected.to be true }
    end

    context 'with Sides with different weight' do
      before { dice.sides.first.weight = 2.0 }

      it { is_expected.to be false }
    end

    it 'has alias methods' do
      expect(dice.method(:fair?)).to eql dice.method(:balanced?)
    end
  end

  describe '#crooked?' do
    subject { dice.crooked? }

    context 'with Sides of the same weight' do
      it { is_expected.to be false }
    end

    context 'with Sides with different weight' do
      before { dice.sides.first.weight = 2.0 }

      it { is_expected.to be true }
    end

    it 'has alias methods' do
      expect(dice.method(:crooked?)).to eql dice.method(:loaded?)
    end
  end

  describe '#weight' do
    subject { dice.weight }

    let(:dice_sides) { 4 }

    before do
      dice.sides[0].weight = 2.32
      dice.sides[1].weight = 3.0
      dice.sides[2].weight = 1.26
      dice.sides[3].weight = 0.72
    end

    it 'returns the total of Sides weights' do
      is_expected.to eql 7.3
    end
  end
end
