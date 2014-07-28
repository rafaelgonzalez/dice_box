module DiceBox
  class Dice
    # Module used for parsing dice notations, as specified on Wikipedia
    #
    # @see http://en.wikipedia.org/wiki/Dice_notation Dice notation (Wikipedia)
    module Notation
      # Regexp used to parse dice notatitons
      NOTATION_REGEX = /^(?<dices>[1-9]*)[D|d](?<sides>[1-9]+[0-0]*)(?<operations>([+\-x\/÷]{1}[0-9]+)*)$/

      # Regexp used to parse operations from dice notations
      OPERATIONS_REGEX = /([+\-x\/÷]{1})([0-9]+)/

      # Parses the given dice notation and returns a Hash representation
      #
      # @example
      #   DiceBox::Dice::Notation.parse('4d20x2÷5')
      #   #=> {
      #         dices: 4,
      #         sides: 20,
      #         operations: [
      #          {operation: :*, number: 2},
      #          {operation: :/, number: 5},
      #         ]
      #       }
      #
      # @param notation [String] the dice notation
      # @return [Hash] representation of the notation
      def self.parse(notation)
        matchdata = notation.match(NOTATION_REGEX)
        fail(ArgumentError, 'provided notation is not valid') if matchdata.nil?
        build_notation_hash(matchdata)
      end

      private

      def self.build_notation_hash(matchdata)
        notation_hash = {
          dices: matchdata[:dices].to_i,
          sides: matchdata[:sides].to_i,
          operations: build_notation_operations_array(matchdata[:operations])
        }

        clean_up_notation_hash(notation_hash)
      end

      def self.build_notation_operations_array(operations_string)
        operations_string.scan(OPERATIONS_REGEX).map do |suffix|
          { operation: operation_mapping(suffix.first), number: suffix.last.to_i }
        end
      end

      def self.operation_mapping(operation)
        if operation == 'x'
          operation = '*'
        elsif operation == '÷'
          operation = '/'
        end

        operation.to_sym
      end

      def self.clean_up_notation_hash(notation_hash)
        notation_hash[:dices] = 1 if notation_hash[:dices] == 0
        notation_hash
      end
    end
  end
end
