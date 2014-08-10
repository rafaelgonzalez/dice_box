module DiceBox
  # Commodity class to use multiple Dice instances at the same time
  class Cup
    # @!attribute [rw] dices
    # @return [Array] the Array of Dices
    attr_accessor :dices

    # @!attribute [r] rolled_sides
    # @return [Array] the last rolled Sides of each Dice
    attr_reader :rolled_sides

    # @!attribute [r] result
    # @return [Integer] the result from the previous roll
    attr_reader :result
    alias_method :rolled, :result
    alias_method :rolled_value, :result

    attr_accessor :operations

    # @param dices [Array] an Array of Dices to put in the Cup
    def initialize(dices = [])
      @dices = dices
      @rolled_sides = []
      @operations = {}
    end

    # Instantiates a Cup and adds dices to it from the given the notation
    #
    # @param notation [String] the dice notation
    # @return [DiceBox::Cup] the Cup instance
    def self.new_from_notation(notation)
      notation_hash = DiceBox::Dice::Notation.parse(notation)

      dices = notation_hash[:dices].times.map do
        Dice.new(notation_hash[:sides])
      end

      cup = new(dices)
      cup.operations = notation_hash[:operations]

      cup
    end

    # Rolls all the Dices in the Cup
    # Applies eventual operations assigned to the Cup
    #
    # @return [Integer] the sum of the rolled Dices
    def roll
      roll = dices.map { |dice| dice.roll }.reduce(&:+)
      roll = apply_operations_to_roll(roll, operations)

      @rolled_sides = dices.map(&:rolled_side)

      @result = roll
    end

    # Returns the highest value the Cup can roll
    # @return [Integer] minimum roll value
    def maximum
      dices.map(&:maximum).reduce(:+)
    end
    alias_method :max, :maximum

    # Returns the lowest value the Cup can roll
    # @return [Integer] minimum roll value
    def minimum
      dices.map(&:minimum).reduce(:+)
    end
    alias_method :min, :minimum

    private

    def apply_operations_to_roll(roll, operations)
      operations.each do |suffix|
        roll = roll.public_send(suffix[:operation], suffix[:number])
      end

      roll
    end
  end
end
