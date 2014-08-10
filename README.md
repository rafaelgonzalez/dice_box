# DiceBox

![Dice Box](https://raw.githubusercontent.com/rafaelgonzalez/dice_box/master/dice.jpg)

[![Gem Version](https://badge.fury.io/rb/dice_box.svg)](http://badge.fury.io/rb/dice_box)
[![Build Status](https://travis-ci.org/rafaelgonzalez/dice_box.svg?branch=master)](https://travis-ci.org/rafaelgonzalez/dice_box)
[![Code Climate](https://codeclimate.com/github/rafaelgonzalez/dice_box.png)](https://codeclimate.com/github/rafaelgonzalez/dice_box)
[![Test Coverage](https://codeclimate.com/github/rafaelgonzalez/dice_box/coverage.png)](https://codeclimate.com/github/rafaelgonzalez/dice_box)

A gem of dices, to get rolling with Ruby.

**Supported Ruby versions:**

- MRI 2.1.0
- MRI 2.0.0
- JRuby 1.7.13

## Installation

Via RubyGems:

    $ gem install dice_box

Or in a Gemfile:

    gem 'dice_box'

## Usage

Complete documentation available [here](http://rubydoc.info/github/rafaelgonzalez/dice_box/frames).

- [DiceBox::Dice](http://rubydoc.info/github/rafaelgonzalez/dice_box/DiceBox/Dice) (rolling dices)
  ```ruby
  # Roll a dice with 7 sides
  DiceBox::Dice.roll(7) # => 4

  # Roll 3 dices with 12 sides
  DiceBox::Dice.roll(12, 3) # => 27

  # Using an instance
  dice = DiceBox::Dice.new(12)
  dice.rolled # => nil
  dice.roll # => 24
  dice.rolled # => 24
  ```

- [DiceBox::Dice::Sides](http://rubydoc.info/github/rafaelgonzalez/dice_box/DiceBox/Dice/Side) (cheating with sides weights)
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

- [DiceBox::Cup](http://rubydoc.info/github/rafaelgonzalez/dice_box/DiceBox/Cup) (rolling multiple dice instances)

  ```ruby
  dices = [DiceBox::Dice.new(6), DiceBox::Dice.new(20), DiceBox::Dice.new(100)]
  cup = DiceBox::Cup.new(dices)

  cup.rolled # => nil
  cup.roll # => 103
  cup.rolled # => 103

  cup.dices[0].rolled # => 2
  cup.dices[1].rolled # => 19
  cup.dices[2].rolled # => 88
  ```

## Versioning

DiceBox follows the principles of [semantic versioning](http://semver.org).

> Given a version number MAJOR.MINOR.PATCH, increment the:

> - MAJOR version when you make incompatible API changes,
> - MINOR version when you add functionality in a backwards-compatible manner, and
> - PATCH version when you make backwards-compatible bug fixes.

> Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

## Similar Libraries

- [GamesDice](https://github.com/neilslater/games_dice) (Ruby gem)
- [Droll](https://github.com/thebinarypenguin/droll) (Javascript)

## License

Copyright :copyright: 2014 Rafaël Gonzalez

Released under the terms of the MIT licence. See the [LICENSE](https://raw.githubusercontent.com/rafaelgonzalez/dice_box/master/LICENSE.txt) file for more details.
