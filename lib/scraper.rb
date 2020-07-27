# Sole purpose is to access remote data

require_relative './module.rb'

class Scraper

    def self.get_page
        page = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/List_of_Colorado_fourteeners"))
        list = []
        page.css("wikitable sortable jquery-tablesorter").each do |item|
            name = page.css(".wikitable td:nth-of-type(2) a[title]")
            range = page.css("td:nth-of-type(3) a")

   
            list << {name: name, range: range}
        end
    end
    list

    
end