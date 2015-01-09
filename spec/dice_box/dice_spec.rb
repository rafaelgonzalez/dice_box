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

  describe '#probabilities' do
    subject { dice.probabilities }

    context 'with a classic dice' do
      it 'returns probabilities only for existing side values' do
        expect(subject.keys).to match_array [1, 2, 3, 4, 5, 6]
      end

      it 'returns a Hash of probabilities for each side' do
        probabilities = subject

        expect(probabilities[1]).to be_within(0.0001).of(0.1666)
        expect(probabilities[2]).to be_within(0.0001).of(0.1666)
        expect(probabilities[3]).to be_within(0.0001).of(0.1666)
        expect(probabilities[4]).to be_within(0.0001).of(0.1666)
        expect(probabilities[5]).to be_within(0.0001).of(0.1666)
        expect(probabilities[6]).to be_within(0.0001).of(0.1666)
      end

      it 'has a total probability of 1.0' do
        expect(subject.values.reduce(:+)).to be_within(0.1).of(1.0)
      end
    end

    context 'with mutliple sides with a 5' do
      before do
        dice.sides[0].value = 5
        dice.sides[1].value = 5
      end

      it 'returns probabilities only for existing side values' do
        expect(subject.keys).to match_array [3, 4, 5, 6]
      end

      it 'returns a Hash of probabilities for each side' do
        probabilities = subject

        expect(probabilities[3]).to be_within(0.0001).of(0.1666)
        expect(probabilities[4]).to be_within(0.0001).of(0.1666)
        expect(probabilities[5]).to eql 0.5
        expect(probabilities[6]).to be_within(0.0001).of(0.1666)
      end

      it 'has a total probability of 1.0' do
        expect(subject.values.reduce(:+)).to be_within(0.1).of(1.0)
      end
    end

    context 'with a loaded Dice' do
      before do
        dice.sides[0].weight = 0.1
        dice.sides[1].weight = 1.8
        dice.sides[2].weight = 2.7
        dice.sides[3].weight = 2.5
        dice.sides[4].weight = 1.2
        dice.sides[5].weight = 1.1
      end

      it 'returns probabilities only for existing side values' do
        expect(subject.keys).to match_array [1, 2, 3, 4, 5, 6]
      end

      it 'returns a Hash of probabilities for each side' do
        probabilities = subject

        expect(probabilities[1]).to be_within(0.000001).of(0.010638)
        expect(probabilities[2]).to be_within(0.000001).of(0.191489)
        expect(probabilities[3]).to be_within(0.000001).of(0.287234)
        expect(probabilities[4]).to be_within(0.000001).of(0.265957)
        expect(probabilities[5]).to be_within(0.000001).of(0.127659)
        expect(probabilities[6]).to be_within(0.000001).of(0.117021)
      end

      it 'has a total probability of 1.0' do
        expect(subject.values.reduce(:+)).to be_within(0.1).of(1.0)
      end
    end
  end

  describe '#probability_for_side' do
    subject { dice.probability_for_side(side) }

    let(:side) { dice.sides.first }

    context 'with a balanced Dice' do
      it { is_expected.to be_within(0.0001).of(0.1666) }
    end

    context 'with a loaded Dice' do
      before do
        dice.sides[0].weight = 2.32
        dice.sides[1].weight = 3.0
        dice.sides[2].weight = 1.26
        dice.sides[3].weight = 0.72
        dice.sides[4].weight = 5.2
        dice.sides[5].weight = 0.91
      end

      it { is_expected.to be_within(0.000001).of(0.173005) }
    end

    context 'with a side that does not exist' do
      let(:side) { DiceBox::Dice::Side.new(1) }

      it { is_expected.to eql 0.0 }
    end

    context 'with a Side defined mutliple times' do
      let(:side) { DiceBox::Dice::Side.new(1) }

      before do
        dice.sides[1] = dice.sides[2] = dice.sides[3] = side
      end

      it { is_expected.to eql 0.5 }
    end
  end

  describe '#probability' do
    subject { dice.probability(value) }
    let(:value) { 5 }

    context 'with one side with a 5' do
      it { is_expected.to be_within(0.0001).of(0.1666) }
    end

    context 'with mutliple sides with a 5' do
      before do
        dice.sides[0].value = 5
        dice.sides[1].value = 5
        dice.sides[2].value = 5
      end

      it { is_expected.to be_within(0.0001).of(0.6666) }
    end

    context 'with a loaded Dice' do
      before do
        dice.sides[0].weight = 0.1
        dice.sides[1].weight = 1.8
        dice.sides[2].weight = 2.7
        dice.sides[3].weight = 2.5
        dice.sides[4].weight = 1.2
        dice.sides[5].weight = 1.1
      end

      it { is_expected.to be_within(0.000001).of(0.127659) }
    end

    context 'with a value that does not exist' do
      let(:value) { 7 }

      it { is_expected.to eql 0.0 }
    end
  end

  describe '#probability_greater_than' do
    subject { dice.probability_greater_than(value) }
    let(:value) { 5 }

    context 'with one side with a 5' do
      it { is_expected.to be_within(0.0001).of(0.1666) }
    end

    context 'with mutliple sides with a 5' do
      before do
        dice.sides[0].value = 5
        dice.sides[1].value = 5
        dice.sides[2].value = 5
      end

      it { is_expected.to be_within(0.0001).of(0.1666) }
    end

    context 'with a loaded Dice' do
      before do
        dice.sides[0].weight = 0.1
        dice.sides[1].weight = 1.8
        dice.sides[2].weight = 2.7
        dice.sides[3].weight = 2.5
        dice.sides[4].weight = 1.2
        dice.sides[5].weight = 1.1
      end

      it { is_expected.to be_within(0.000001).of(0.117021) }
    end

    context 'with a value that does not exist' do
      context 'below the minimum' do
        let(:value) { 0 }

        it { is_expected.to eql 1.0 }
      end

      context 'above the maximum' do
        let(:value) { 7 }

        it { is_expected.to eql 0.0 }
      end
    end
  end

  describe '#probability_greater_than_or_equal' do
    subject { dice.probability_greater_than_or_equal(value) }
    let(:value) { 5 }

    context 'with one side with a 5' do
      it { is_expected.to be_within(0.0001).of(0.3333) }
    end

    context 'with mutliple sides with a 5' do
      before do
        dice.sides[0].value = 5
        dice.sides[1].value = 5
      end

      it { is_expected.to be_within(0.0001).of(0.6666) }
    end

    context 'with a loaded Dice' do
      before do
        dice.sides[0].weight = 0.1
        dice.sides[1].weight = 1.8
        dice.sides[2].weight = 2.7
        dice.sides[3].weight = 2.5
        dice.sides[4].weight = 1.2
        dice.sides[5].weight = 1.1
      end

      it { is_expected.to be_within(0.000001).of(0.244680) }
    end

    context 'with a value that does not exist' do
      context 'below the minimum' do
        let(:value) { 0 }

        it { is_expected.to eql 1.0 }
      end

      context 'above the maximum' do
        let(:value) { 7 }

        it { is_expected.to eql 0.0 }
      end
    end
  end

  describe '#probability_lower_than' do
    subject { dice.probability_lower_than(value) }
    let(:value) { 5 }

    context 'with one side with a 5' do
      it { is_expected.to be_within(0.0001).of(0.6666) }
    end

    context 'with mutliple sides with a 5' do
      before do
        dice.sides[0].value = 5
        dice.sides[1].value = 5
      end

      it { is_expected.to be_within(0.0001).of(0.3333)  }
    end

    context 'with a loaded Dice' do
      before do
        dice.sides[0].weight = 0.1
        dice.sides[1].weight = 1.8
        dice.sides[2].weight = 2.7
        dice.sides[3].weight = 2.5
        dice.sides[4].weight = 1.2
        dice.sides[5].weight = 1.1
      end

      it { is_expected.to be_within(0.000001).of(0.755319) }
    end

    context 'with a value that does not exist' do
      context 'below the minimum' do
        let(:value) { 0 }

        it { is_expected.to eql 0.0 }
      end

      context 'above the maximum' do
        let(:value) { 7 }

        it { is_expected.to eql 1.0 }
      end
    end
  end

  describe '#probability_lower_than_or_equal' do
    subject { dice.probability_lower_than_or_equal(value) }
    let(:value) { 5 }

    context 'with one side with a 5' do
      it { is_expected.to be_within(0.0001).of(0.8333) }
    end

    context 'with mutliple sides with a 5' do
      before do
        dice.sides[0].value = 5
        dice.sides[1].value = 5
      end

      it { is_expected.to be_within(0.0001).of(0.8333) }
    end

    context 'with a loaded Dice' do
      before do
        dice.sides[0].weight = 0.1
        dice.sides[1].weight = 1.8
        dice.sides[2].weight = 2.7
        dice.sides[3].weight = 2.5
        dice.sides[4].weight = 1.2
        dice.sides[5].weight = 1.1
      end

      it { is_expected.to be_within(0.000001).of(0.882978) }
    end

    context 'with a value that does not exist' do
      context 'below the minimum' do
        let(:value) { 0 }

        it { is_expected.to eql 0.0 }
      end

      context 'above the maximum' do
        let(:value) { 7 }

        it { is_expected.to eql 1.0 }
      end
    end
  end
end
