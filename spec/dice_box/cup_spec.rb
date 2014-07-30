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
end
