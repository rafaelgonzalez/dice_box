describe DiceBox::Dice::Notation do
  subject { described_class }

  describe '.parse' do
    context "passing 'D6'" do
      it 'returns 1 dice of 6 sides' do
        match = described_class.parse('D6')

        expect(match[:dices]).to eql 1
        expect(match[:sides]).to eql 6
        expect(match[:operations]).to be_empty
      end
    end

    context "passing '1d6'" do
      it 'returns 1 dice of 6 sides' do
        match = described_class.parse('1d6')

        expect(match[:dices]).to eql 1
        expect(match[:sides]).to eql 6
        expect(match[:operations]).to be_empty
      end
    end

    context "passing '4d20'" do
      it 'returns 4 dices of 20 sides' do
        match = described_class.parse('4d20')

        expect(match[:dices]).to eql 4
        expect(match[:sides]).to eql 20
        expect(match[:operations]).to be_empty
      end
    end

    context "passing '2d4+7'" do
      it 'returns 2 dice of 7 sides plus 7' do
        match = described_class.parse('2d4+7')

        expect(match[:dices]).to eql 2
        expect(match[:sides]).to eql 4
        expect(match[:operations]).to eql([{ operation: :+, number: 7 }])
      end
    end

    context "passing '3d9-4'" do
      it 'returns 3 dices of 9 minus 4' do
        match = described_class.parse('3d9-4')

        expect(match[:dices]).to eql 3
        expect(match[:sides]).to eql 9
        expect(match[:operations]).to eql([{ operation: :-, number: 4 }])
      end
    end

    context "passing '8d3x5'" do
      it 'returns 8 dices of 3 sides multiplied by 5' do
        match = described_class.parse('8d3x5')

        expect(match[:dices]).to eql 8
        expect(match[:sides]).to eql 3
        expect(match[:operations]).to eql([{ operation: :*, number: 5 }])
      end
    end

    context "passing 'd30÷2'" do
      it 'returns 1 dice of 30 sides divided by 5' do
        match = described_class.parse('d30÷2')

        expect(match[:dices]).to eql 1
        expect(match[:sides]).to eql 30
        expect(match[:operations]).to eql([{ operation: :/, number: 2 }])
      end
    end

    context "passing '2d4+7'" do
      it 'returns 2 dice of 7 sides plus 7' do
        match = described_class.parse('2d4+7')

        expect(match[:dices]).to eql 2
        expect(match[:sides]).to eql 4
        expect(match[:operations]).to eql([{ operation: :+, number: 7 }])
      end
    end

    context "passing '8d6+12x2/5'" do
      it 'returns 2 dice of 7 sides plus 7' do
        match = described_class.parse('8d6+12x2/5')

        expect(match[:dices]).to eql 8
        expect(match[:sides]).to eql 6
        expect(match[:operations]).to eql([
          { operation: :+, number: 12 },
          { operation: :*, number: 2 },
          { operation: :/, number: 5 }
        ])
      end
    end

    context "passing 'd7+'" do
      it 'raises an ArgumentError' do
        expect { described_class.parse('d7+') }.to raise_error(ArgumentError)
      end
    end

    context "passing 'd5+3x2+'" do
      it 'raises an ArgumentError' do
        expect { described_class.parse('d5+3x2+') }.to raise_error(ArgumentError)
      end
    end

    context "passing '0d0÷2'" do
      it 'raises an ArgumentError' do
        expect { described_class.parse('0d0÷2') }.to raise_error(ArgumentError)
      end
    end

    context "passing '4d'" do
      it 'raises an ArgumentError' do
        expect { described_class.parse('4d') }.to raise_error(ArgumentError)
      end
    end
  end
end
