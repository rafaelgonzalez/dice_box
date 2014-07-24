module DiceSet
  class Dice
    attr_reader :sides

    def initialize(sides)
      @sides = sides
    end

    def self.roll(sides, amount = 1)
      return 0 if amount.nil? || amount <= 0

      amount.times.collect do
        Random.new.rand(1..sides)
      end.inject(&:+)
    end

    def roll
      self.class.roll(sides, 1)
    end
  end
end
