module DiceBox
  # Representation of a dice
  class Dice
    # @!attribute [r] sides
    # @return [Array] the Array of Sides of the Dice
    attr_reader :sides

    # @!attribute [r] rolled_side
    # @return [Array] the last rolled Side
    attr_reader :rolled_side

    # @param sides_number [Integer] the number of Sides this Dice should have
    def initialize(sides_number)
      @sides = build_sides(sides_number)
      @rolled_side = nil
    end

    # Rolls multiple dices with the same number of sides
    # @param sides_number [Integer] the number of sides of the dices
    # @param amount [Integer] the number of dices rolled
    # @return [Integer] the total roll result
    def self.roll(sides_number, amount = 1)
      return 0 if amount.nil? || amount <= 0

      amount.times.map do
        Random.new.rand(1..sides_number)
      end.reduce(&:+)
    end

    # Rolls the dice
    # @note Sets #rolled_side to the rolled Side
    # @return [Integer] the value of the rolled Side
    def roll
      @rolled_side = balanced? ? sides.sample : weighted_roll
      rolled_side.value
    end

    # Returns the last value rolled
    # @return [Integer] the last rolled value.
    def rolled
      @rolled_side ? @rolled_side.value : nil
    end

    # Determines if all Sides of the Dice have the same weight
    # @return [Boolean]
    def balanced?
      !crooked?
    end

    # Determines if at least one Side has a different weight than any other Side of the Dice
    # @return [Boolean]
    def crooked?
      sides.map(&:weight).any? do |weight|
        weight != sides.first.weight
      end
    end

    # The weight of the Dice, sum of all Sides weights
    # @return [Float] the weight of the Dice
    def weight
      sides.map(&:weight).reduce(&:+)
    end

    private

    # Instantiates multiple Sides
    # @param sides_number [Integer] the number of Sides to instantiate
    # @return [Array] the Array of instantiated Sides
    def build_sides(sides_number)
      sides_number.times.map do |number|
        Side.new(number + 1)
      end
    end

    # Rolls the Dice taking Sides weights into account
    # @return [Side] the rolled Side
    def weighted_roll
      num = rand(0..weight)

      sides.each do |side|
        return side if side.weight > num
        num = num - side.weight
      end
    end
  end
end
