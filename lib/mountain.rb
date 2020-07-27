# Initialize, instance/class methods, other attributes
# Immeditely create instances with API data
# Keep track of all objects in a class variable


class Mountain

    attr_accessor :name, :range

    @@all = []

    def initialize(mountain_hash)
        mountain_hash.each do |k, v|
            self.send("#{k}=", v)
        end
        @@all << self
    end

    def self.make_list(mountain_array)
        mountain_array.each do |hash|
            Mountain.new(hash)
        end
    end

    def self.all
        @@all
    end

    def self.reset_all
        @@all.clear
    end

end