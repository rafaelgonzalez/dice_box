module DiceSet

  # The Dice class is the representation of a dice.
  class Dice

    # @!attribute [r] sides
    # @return [Fixnum] the number of sides of the dice

    attr_reader :sides

    # @param sides [Fixnum] the number of sides of the dice
    def initialize(sides)
      @sides = sides
    end

    # Rolls multiple dices with the same number of sides.
    # @param sides [Fixnum] the number of sides of the dices
    # @param amount [Fixnum] the number of dices rolled
    # @return [Fixnum] the total roll result
    def self.roll(sides, amount = 1)
      return 0 if amount.nil? || amount <= 0

      amount.times.collect do
        Random.new.rand(1..sides)
      end.inject(&:+)
    end

    # Rolls the dice.
    # @return [Fixnum] the roll result
    def roll
      self.class.roll(sides, 1)
    end
  end
end
