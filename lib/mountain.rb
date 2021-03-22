class Mountain

  attr_accessor :name, :range, :elevation, :prominence, :location, :rank,
                :stats, :mtn_url, :bio, :temp, :description
  
  #array which stores all attributes after they are scraped (as per the initializer)
  @@all = []

  #send calls the method name (key) with an argument of the value and dynamically assigns them
  #ex:
  #{:rank=>"1", :name=>"Mount Elbert", :range=>"Sawatch Range", :elevation=>"14,440 ft", :prominence=>"9,093 ft", :location=>"39.1178°N 106.4454°W", :mtn_url=>"/wiki/Mount_Elbert"}
  #etc.

  #initializes by assigning all attributes each time a new Mountain instance is created
  def initialize(hash)
    hash.each do |k, v|
      self.send("#{k}=", v)
    end
    @@all << self
  end
  
  def self.all
    @@all
  end

  #returns one specific mountain given its rank
  def self.search(rank)
     self.all[rank]
  end

  #iterates through each mountain hash given the full list array as an argument
  #creating a new Mountain instance from each, taking in that hash as its argument
  #(list = full list of key/val pairs, hash = a single mountain's attributes)
  def self.create_from_scrape(list)
    list.each do |mtn_hash|
      Mountain.new(mtn_hash)
    end
  end

end