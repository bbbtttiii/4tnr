# Sole purpose is to access remote data

require_relative './mountain.rb'

class Scraper

    def self.get_page #returns a scraped array of mountain info
        page = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/List_of_Colorado_fourteeners"))
        list = []
        
        page.css(".wikitable").each do |item|
            rank = item.css("td:nth-of-type(1)")
            name = item.css("td:nth-of-type(2) a[title]")
            range = item.css("td:nth-of-type(3) a[title]")
            elevation = item.css("td:nth-of-type(4)")
            location = item.css("td span.geo-dec")
            stats = {
                :rank => rank.text.strip,
                :name => name.text.strip,
                :range => range.text.strip,
                :elevation => elevation.text.strip,
                :location => location.text.strip
            }
            
            list << stats
        end
        list

    end
    
end