describe DiceBox::Cup do
  let(:cup) { described_class.new(dices) }
  let(:dices) { [] }

  describe '#roll' do
    subject { cup.roll }

    let(:dice_1) { DiceBox::Dice.new(6) }
    let(:dice_2) { DiceBox::Dice.new(4) }
    let(:dice_3) { DiceBox::Dice.new(12) }
    let(:dices) { [dice_1, dice_2, dice_3] }

    it 'returns the sum of the rolled values' do
      expect(dice_1).to receive(:roll).and_return(3)
      expect(dice_2).to receive(:roll).and_return(1)
      expect(dice_3).to receive(:roll).and_return(10)

      is_expected.to eql 14
    end
  end

  describe '#result' do
    subject { cup.rolled }

    let(:dice_1) { DiceBox::Dice.new(6) }
    let(:dice_2) { DiceBox::Dice.new(4) }
    let(:dice_3) { DiceBox::Dice.new(12) }
    let(:dices) { [dice_1, dice_2, dice_3] }

    it 'returns the sum of the last rolled values' do
      rolled_value = cup.roll

      is_expected.to eql rolled_value
    end

    it 'does not change value if dices are rerolled' do
      rolled_value = cup.roll

      is_expected.to eql rolled_value

      expect(dice_1).to receive(:roll).and_return(1)
      expect(dice_2).to receive(:roll).and_return(1)
      expect(dice_3).to receive(:roll).and_return(1)

      dice_1.roll
      dice_2.roll
      dice_3.roll

      is_expected.to eql rolled_value
    end
  end

  describe '#rolled_sides' do
    subject { cup.rolled_sides }

    let(:dice_1) { DiceBox::Dice.new(6) }
    let(:dice_2) { DiceBox::Dice.new(4) }
    let(:dice_3) { DiceBox::Dice.new(12) }
    let(:dices) { [dice_1, dice_2, dice_3] }

    it 'returns an Array of Sides' do
      is_expected.to be_an(Array)
      is_expected.to be_empty

      cup.roll

      is_expected.to be_an(Array)
    end

    it 'does not change if dices are not rolled with the cup' do
      cup.roll
      rolled_sides = cup.rolled_sides

      dice_1.roll
      dice_2.roll
      dice_3.roll

      is_expected.to eql rolled_sides
    end
  end

  describe '#maximum' do
    subject { cup.maximum }

    let(:dices) do
      [
        DiceBox::Dice.new(6),
        DiceBox::Dice.new(20),
        DiceBox::Dice.new(100)
      ]
    end

    context 'with classical dices' do
      it { is_expected.to eql 126 }
    end

    context 'with dices with changed side values' do
      before do
        dices[0].sides[0].value = 56
        dices[1].sides[0].value = 98
        dices[2].sides[0].value = 112
      end

      it { is_expected.to eql 266 }
    end
  end

  describe '#minimum' do
    subject { cup.minimum }

    let(:dices) do
      [
        DiceBox::Dice.new(6),
        DiceBox::Dice.new(6),
        DiceBox::Dice.new(6)
      ]
    end

    context 'with classical dices' do
      it { is_expected.to eql 3 }
    end

    context 'with dices with changed side values' do
      before do
        dices.each do |dice|
          dice.sides[0].value = 102
          dice.sides[1].value = 206
          dice.sides[2].value = 191
          dice.sides[3].value = 76
          dice.sides[4].value = 213
          dice.sides[5].value = 87
        end
      end

      it { is_expected.to eql 228 }
    end
  end
end
