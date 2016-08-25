# SimplifyRb - Polyline simplification

[![Build Status](https://travis-ci.org/odlp/simplify_rb.svg?branch=master)](https://travis-ci.org/odlp/simplify_rb) [![Gem Version](https://badge.fury.io/rb/simplify_rb.svg)](https://badge.fury.io/rb/simplify_rb)

SimplifyRb is a Ruby port of [simplify.js](https://github.com/mourner/simplify-js) by Vladimir Agafonkin.

You can use this gem to reduce the number of points in a complex polyline / polygon, making use of an optimized Douglas-Peucker algorithm.

## Installation

Add this line to your application's Gemfile:

    gem 'simplify_rb'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simplify_rb

## Usage

```ruby
require 'simplify_rb'

points = [
  { x: 51.5256, y: -0.0875 },
  { x: 51.7823, y: -0.0912 }
]
tolerance = 1
high_quality = true

SimplifyRb::Simplifier.new.process(points, tolerance, high_quality)
```

```points```: An array of hashes, containing x,y coordinates.

```tolerance```: (optional, 1 by default): Affects the amount of simplification that occurs (the smaller, the less simplification).

```high_quality```: (optional, False by default): Flag to exclude the distance pre-processing. Produces higher quality results when true is passed, but runs slower.

### Custom points

You can also use custom points, such as a struct or object which responds to `:x` and `:y`, rather than hashes:

```ruby
CustomPointStruct = Struct.new(:x, :y)

custom_points = [
  CustomPointStruct.new(51.5256, -0.0875),
  CustomPointStruct.new(51.7823, -0.0912)
]

tolerance = 1
high_quality = true

SimplifyRb::Simplifier.new.process(custom_points, tolerance, high_quality)
```
