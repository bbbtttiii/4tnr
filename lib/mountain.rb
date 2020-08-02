class Mountain

    #getter methods (hook/callback to read the attribute)

  # def name
  #   @name = name
  # end

    #and setter methods (defines the attribute)

  # def name=(name)
  #   @name = name
  # end
  attr_accessor :name, :range, :elevation, :prominence, :location, :rank,
                :stats, :lat, :long, :mtn_url, :bio, :speed, :temp, :description
  
  #class variable array which stores all attributes AFTER they are scraped as per the initializer
  @@all = []

  #initializes by assigning all attributes each time a new Mountain instance is created
  def initialize(hash)
    hash.each do |k, v|
      self.send("#{k}=", v)
    end
    @@all << self
  end
  
  #class method that returns the @@all array
  def self.all
    @@all
  end

  #class method that iterates through the 
  def self.create_from_scrape(list)
    list.each do |hash|
      Mountain.new(hash)
    end
  end

  #class method that
  def self.search(mountain)
    self.all[mountain]
  end

  #
  def add_mtn_bio(bio_hash)
    bio_hash.each do |k, v|
      self.send("#{k}=", v)
    end
    self
  end

end