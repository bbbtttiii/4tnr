# Initialize, instance/class methods, other attributes
# Immeditely create instances with API data
# Keep track of all objects in a class variable


class Mountain

    attr_accessor :name, :range, :elevation, :location, :rank

    @@all = []
    
    def self.create_from_scrape(list)
        list.each do |hash|
          Mountain.new(hash)
        end
    end

    def initialize(hash)
        hash.each do |k, v|
          self.send("#{k}=", v)
        end
        @@all << self
      end
    

    def self.all
        @@all
    end

    def self.find_by_name(name)
        self.all.find{|mountain| mountain.name == name}
    end

end


