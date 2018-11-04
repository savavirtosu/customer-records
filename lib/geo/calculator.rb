require './lib/geo/coordinates'
module Geo
  # Custom Error raised by the calculator in case it gets weird input
  class CalculatorError < StandardError
  end

  class Calculator
    RAD_PER_DEG = Math::PI / 180
    RM = 6_371_000 # Earth radius in meters.

    # Calculate the distance between 2 geo coordinates on the Earth _sphere_
    #
    # @param [Geo::Coordinates, Geo::Coordinates] c1, c2 The coordinates of two points
    #
    # @return [Float] Distance between points in meters
    #
    # raise Geo::CalculatorError if invalid coordinates given
    def distance_between(c1, c2)
      raise CalculatorError, 'Invalid Geo::Coordinates' unless valid_coordinates?(c1) && valid_coordinates?(c2)

      # convert degrees to radians
      lat1_rad, lat2_rad = c1.latitude * RAD_PER_DEG, c2.latitude * RAD_PER_DEG
      lon1_rad, lon2_rad = c1.longitude * RAD_PER_DEG, c2.longitude * RAD_PER_DEG

      # Considering the Earth a perfect sphere
      # Applling the first formula from: https://en.wikipedia.org/wiki/Great-circle_distance
      c = Math.acos(
        Math.sin(lat1_rad) * Math.sin(lat2_rad) +
        Math.cos(lat1_rad) * Math.cos(lat2_rad) *
        Math.cos(lon1_rad - lon2_rad)
      )

      RM * c # Delta in meters
    end

    private

    def valid_coordinates?(c)
      c && c.is_a?(Geo::Coordinates)
    end
  end
end
