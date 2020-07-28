# Initialize, instance/class methods, other attributes
# Immeditely create instances with API data
# Keep track of all objects in a class variable


class Mountain

    attr_accessor :name, :range, :elevation, :location, :rank, :stats

    @@all = []
    
    def initialize(hash) 
      hash.each do |k, v|
        self.send("#{k}=", v)
      end
      @@all << self
    end
      
    def self.create_from_scrape(list)
      list.each do |hash|
        Mountain.new(hash)
      end
    end

    def self.all
      @@all
      # binding.pry
    end

    # def self.find_by_name(input)
    #   self.all.find{|mountain| mountain.name == input}
    # end

end