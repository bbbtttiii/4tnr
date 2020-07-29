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
  end

  def self.find(mountain)
    self.all[mountain]
  end

end