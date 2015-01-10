module DiceBox
  # Representation of a dice
  class Dice
    # @!attribute [r] sides
    # @return [Array] the Array of Sides of the Dice
    attr_reader :sides

    # @!attribute [r] rolled_side
    # @return [Dice::Side] the last rolled Side
    attr_reader :rolled_side

    # @!attribute [r] rolled
    # @return [Integer] the result from the previous roll
    attr_reader :rolled
    alias_method :result, :rolled
    alias_method :rolled_value, :rolled

    # @param sides_number [Integer] the number of Sides this Dice should have
    def initialize(sides_number)
      @sides = build_sides(sides_number)
      @rolled_side = nil
      @rolled = nil
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
    # @note Sets #rolled_value to the rolled Side's value
    # @return [Integer] the value of the rolled Side
    def roll
      @rolled_side = balanced? ? sides.sample : weighted_roll
      @rolled = rolled_side.value
    end

    # Returns the highest value the Dice can roll
    # @return [Integer] maximum roll value
    def maximum
      sides.map(&:value).max
    end
    alias_method :max, :maximum

    # Returns the lowest value the Dice can roll
    # @return [Integer] minimum roll value
    def minimum
      sides.map(&:value).min
    end
    alias_method :min, :minimum

    # Determines if all Sides of the Dice have the same weight
    # @return [Boolean]
    def fair?
      !crooked?
    end
    alias_method :balanced?, :fair?

    # Determines if at least one Side has a different weight than any
    # other Side of the Dice
    # @return [Boolean]
    def crooked?
      sides.map(&:weight).any? do |weight|
        weight != sides.first.weight
      end
    end
    alias_method :loaded?, :crooked?

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
        num -= side.weight
      end
    end
  end
end
