# SimplifyRb - Polyline simplification

[![Codeship Status for odlp/simplify_rb](https://www.codeship.io/projects/2a8ed250-47d5-0132-a14f-46b32a25e7b0/status)](https://www.codeship.io/projects/45709)

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

SimplifyRb.simplify(points, tolerance, high_quality)
```

```points```: An array of hashes, containing x,y coordinates: ```{x: 51.5256, y: -0.0875}```

```tolerance```: (optional, 1 by default): Affects the amount of simplification that occurs (the smaller, the less simplification)

```highestQuality```: (optional, False by default): Flag to exclude the distance pre-processing. Produces higher quality results when true is passed, but runs slower