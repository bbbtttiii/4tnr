class Mountain

  attr_accessor :name, :range, :elevation, :prominence, :location, :rank,
                :stats, :lat, :long, :mtn_url, :bio, :speed, :temp, :description
  
  @@all = []

  def initialize(hash)
    hash.each do |k, v|
      self.send("#{k}=", v)
    end
    @@all << self
  end
  
  def self.all
    @@all
  end
    
  def self.create_from_scrape(list)
    list.each do |hash|
      Mountain.new(hash)
    end
  end

  def self.find(mountain)
    self.all[mountain]
  end

  def add_mtn_bio(bio_hash)
    bio_hash.each do |k, v|
      self.send("#{k}=", v)
    end
    self
  end

end