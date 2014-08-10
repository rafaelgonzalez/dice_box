module DiceBox
  # Commodity class to use multiple Dice instances at the same time
  class Cup
    # @!attribute [rw] dices
    # @return [Array] the Array of Dices
    attr_accessor :dices

    # @!attribute [r] result
    # @return [Integer] the result from the previous roll
    attr_reader :result
    alias_method :rolled, :result
    alias_method :rolled_value, :result

    # @param dices [Array] an Array of Dices to put in the Cup
    def initialize(dices = [])
      @dices = dices
    end

    # Rolls all the Dices in the Cup
    # @return [Integer] the sum of the rolled Dices
    def roll
      @result = dices.map { |dice| dice.roll }.reduce(&:+)
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
  end
end
