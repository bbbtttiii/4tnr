# Sole purpose is to access remote data

require_relative './mountain.rb'

class Scraper

    def get_page(url) #returns a scraped array of mountain info
        page = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/List_of_Colorado_fourteeners"))
        list = {}
        
        page.css("wikitable sortable jquery-tablesorter").each do |item|
            name = item.css(".wikitable td:nth-of-type(2) a[title]")
            range = item.css("td:nth-of-type(3) a")

   
            list << {name: name, range: range}
        end
        list
    end

end  