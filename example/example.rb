require 'simplify_rb'

points = [
  { x: 51.5256, y: -0.0875 },
  { x: 51.7823, y: -0.0912 }
]
tolerance = 1
high_quality = true

SimplifyRb::Simplifier.new.process(points, tolerance, high_quality)
