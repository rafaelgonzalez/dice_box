module DiceSet
  class Dice

    # The Side class is the representation of the side of a dice.
    class Side

      # @!attribute [r] value
      # @return [Fixnum] the actual value of the Side

      attr_reader :value

      # @param value [Fixnum] the actual value of the Side
      def initialize(value)
        @value = value
      end
    end
  end
end
