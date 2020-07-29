require_relative './mountain.rb'

class Scraper

    def self.get_page #returns a scraped array of mountain info
        page = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/List_of_Colorado_fourteeners"))
        list = []
        
        page.css(".wikitable tbody tr").each do |item|
            # binding.pry
            rank = item.css("td:nth-of-type(1)").text.strip
            name = item.css("td:nth-of-type(2) a[title]").text
            range = item.css("td:nth-of-type(3) a[title]").text
            elevation = item.css("td:nth-of-type(4)").text
            location = item.css("td span.geo-dec").text
            stats = {
                :rank => rank,
                :name => name,
                :range => range,
                :elevation => elevation,
                :location => location
            }
            list << stats
        end
        list
    end
    
end