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
                :stats, :mtn_url, :bio, :speed, :temp, :description
  
  #class variable array which stores all attributes AFTER they are scraped (as per the initializer)
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

    #class method that returns one specific mountain given its rank
  def self.search(rank)
     self.all[rank]
  end

  #class method that iterates through each mountain hash given the full list array as an argument
  #creating a new Mountain instance from each, taking in that hash as its argument
  #(list = full list of key/val pairs, hash = a single mountain's attributes)
  def self.create_from_scrape(list)
    list.each do |mtn_hash|
      Mountain.new(mtn_hash)
    end

  end

  #takes in bio_hash as argument, iterates over the key/val pairs from scraped hash
  #assigns Mountain class each key/value pair and returns self (Mountain)
  def add_mtn_bio(bio_hash)
    bio_hash.each do |k, v|
      self.send("#{k}=", v)
    end
    self
  end

end