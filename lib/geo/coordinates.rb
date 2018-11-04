module Geo
  class Coordinates
    attr_accessor :lat, :lng

    # Provide users with the ability to use :latitude and :longitude
    # to access the lat/lng instance variables.
    # Alias the attr_accessor :lat to :latitude
    alias_method :latitude, :lat
    alias_method :latitude=, :lat=
    # Alias the attr_accessor :lng to :longitude
    alias_method :longitude, :lng
    alias_method :longitude=, :lng=

    # Accepts latitude and longitude or instantiates an empty instance
    # if lat and lng are not provided. Converted to floats if provided
    def initialize(lat = nil, lng = nil)
      lat = lat.to_f if lat && !lat.is_a?(Numeric)
      lng = lng.to_f if lng && !lng.is_a?(Numeric)
      @lat = lat
      @lng = lng
    end

    def self.from_json(json)
      new(json['latitude'], json['longitude'])
    end

    # Latitude attribute setter; stored as a float.
    def latitude=(lat)
      @lat = lat.to_f if lat
    end

    # Longitude attribute setter; stored as a float;
    def longitude=(lng)
      @lng = lng.to_f if lng
    end
  end
end
