describe DiceBox::Cup do
  let(:dices) { [] }
  subject { described_class.new(dices) }

  describe '#roll' do
    let(:dice_1) { DiceBox::Dice.new(6) }
    let(:dice_2) { DiceBox::Dice.new(4) }
    let(:dice_3) { DiceBox::Dice.new(12) }
    let(:dices) { [dice_1, dice_2, dice_3] }

    it 'returns the sum of the rolled values' do
      expect(dice_1).to receive(:roll).and_return(3)
      expect(dice_2).to receive(:roll).and_return(1)
      expect(dice_3).to receive(:roll).and_return(10)

      expect(subject.roll).to eql 14
    end
  end

  describe '#rolled' do
    let(:dice_1) { DiceBox::Dice.new(6) }
    let(:dice_2) { DiceBox::Dice.new(4) }
    let(:dice_3) { DiceBox::Dice.new(12) }
    let(:dices) { [dice_1, dice_2, dice_3] }

    it 'returns the sum of the last rolled values' do
      rolled_value = subject.roll

      expect(subject.rolled).to eql rolled_value
    end

    it 'does not change value if dices are rerolled' do
      rolled_value = subject.roll

      expect(subject.rolled).to eql rolled_value

      expect(dice_1).to receive(:roll).and_return(1)
      expect(dice_2).to receive(:roll).and_return(1)
      expect(dice_3).to receive(:roll).and_return(1)

      dice_1.roll
      dice_2.roll
      dice_3.roll

      expect(subject.rolled).to eql rolled_value
    end
  end

  describe '#maximum' do
    let(:dices) { [DiceBox::Dice.new(6), DiceBox::Dice.new(20), DiceBox::Dice.new(100)] }
    subject { DiceBox::Cup.new(dices) }

    context 'with classical dices' do
      it 'returns the highest value the cup can roll' do
        expect(subject.maximum).to eql 126
      end
    end

    context 'with dices with changed side values' do
      before do
        dices[0].sides[0].value = 56
        dices[1].sides[0].value = 98
        dices[2].sides[0].value = 112
      end

      it 'returns the highest value the cup can roll' do
        expect(subject.maximum).to eql 266
      end
    end
  end

  describe '#minimum' do
    let(:dices) { [DiceBox::Dice.new(6), DiceBox::Dice.new(6), DiceBox::Dice.new(6)] }
    subject { DiceBox::Cup.new(dices) }

    context 'with classical dices' do
      it 'returns the lowest value the cup can roll' do
        expect(subject.minimum).to eql 3
      end
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

      it 'returns the lowest value the cup can roll' do
        expect(subject.minimum).to eql 228
      end
    end
  end
end
