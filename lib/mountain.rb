# Initialize, instance/class methods, other attributes
# Immeditely create instances with API data
# Keep track of all objects in a class variable


class Mountain

    attr_accessor :name, :range, :elevation, :location, :rank

    @@all = []

    def initialize()
        @@all << self
    end

    def self.all
        @@all
    end

    def self.reset_all
        @@all.clear
    end

end

