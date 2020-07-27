# Initialize, instance/class methods, other attributes
# Immeditely create instances with API data
# Keep track of all objects in a class variable

require 'open-uri'

class Module

    attr_accessor :name, :range, :elevation, :prominence, :location

    @@all = []

    def initialize(name, range, elevation, prominence, location)
        @name = name
        @range = range
        @elevation = elevation
        @prominence = prominence
        @location = location
        @@all << self
    end

    def self.all
        @@all
    end

    def self.reset_all
        @@all.clear
    end

end