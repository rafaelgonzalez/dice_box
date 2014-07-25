module DiceBox
  class Dice

    # The Side class is the representation of the side of a dice.
    class Side

      # @!attribute [r] value
      # @return [Integer] the actual value of the Side
      attr_reader :value

      # @!attribute [rw] weight
      # @return [Float] the weight of the Side
      attr_accessor :weight

      # @param value [Integer] the actual value of the Side
      # @param weight [Float] the weight of the Side
      def initialize(value, weight = 1.0)
        @value = value
        @weight = weight
      end
    end
  end
end
