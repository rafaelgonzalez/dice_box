# DiceBox

![Dice Box](https://raw.githubusercontent.com/rafaelgonzalez/dice_box/master/dice.jpg)

[![Build Status](https://travis-ci.org/rafaelgonzalez/dice_box.svg?branch=master)](https://travis-ci.org/rafaelgonzalez/dice_box)
[![Code Climate](https://codeclimate.com/github/rafaelgonzalez/dice_box.png)](https://codeclimate.com/github/rafaelgonzalez/dice_box)
[![Test Coverage](https://codeclimate.com/github/rafaelgonzalez/dice_box/coverage.png)](https://codeclimate.com/github/rafaelgonzalez/dice_box)

A gem of dices, to get rolling with Ruby.

**Supported Ruby versions:**

- 2.1.0
- 2.0.0
- 1.9.3

## Installation

Add this line to your application's Gemfile:

    gem 'dice_box'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dice_box

## Usage

### Rolling dices

**Without instantiating**

```ruby
# Roll a dice with 7 sides
DiceBox::Dice.roll(7) # => 4

# Roll 3 dices with 12 sides
DiceBox::Dice.roll(12, 3) # => 27
```

**Instantiate a dice with the number of sides you want**

```ruby
dice = DiceBox::Dice.new(12)
dice.rolled_side # => nil
dice.roll # => 24

dice.rolled_side # => #<DiceBox::Dice::Side>
dice.rolled_side.value # => 24
```

### Cheating with Sides weights

You can alter the chances of appearence of any side by changing its weight:

```ruby
dice = DiceBox::Dice.new(3)
dice.sides[0].weight = 0.0
dice.sides[1].weight = 2.0

dice.roll # => 2
dice.roll # => 3
dice.roll # => 2
dice.roll # => 2
dice.roll # => 2
```

## Documentation

[The documentation](http://rubydoc.info/github/rafaelgonzalez/dice_box/master/frames) is generated with [YARD](http://yardoc.org/).

## Contributing

1. Fork it ( http://github.com/rafaelgonzalez/dice_box/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright :copyright: 2014 Rafaël Gonzalez

Released under the terms of the MIT licence. See the LICENSE file for more details.
