module DiceSet

  # The Dice class is the representation of a dice.
  class Dice

    # @!attribute [r] sides
    # @return [Array] the Array of Sides of the Dice
    attr_reader :sides

    # @!attribute [r] current_side
    # @return [Array] the last rolled Side
    attr_reader :current_side

    # @param sides_number [Integer] the number of Sides this Dice should have
    def initialize(sides_number)
      @sides = build_sides(sides_number)
      @current_side = nil
    end

    # Rolls multiple dices with the same number of sides.
    # @param sides_number [Integer] the number of sides of the dices
    # @param amount [Integer] the number of dices rolled
    # @return [Integer] the total roll result
    def self.roll(sides_number, amount = 1)
      return 0 if amount.nil? || amount <= 0

      amount.times.collect do
        Random.new.rand(1..sides_number)
      end.inject(&:+)
    end

    # Rolls the dice.
    # @note Sets #current_side to the rolled Side
    # @return [Integer] the value of the rolled Side
    def roll
      @current_side = sides.sample
      current_side.value
    end

    private

    # Instanciates multiple Sides.
    # @param sides_number [Integer] the number of Sides to instanciate
    # @return [Array] the Array of instanciated Sides
    def build_sides(sides_number)
      sides_number.times.map do |number|
        Side.new(number + 1)
      end
    end
  end
end
