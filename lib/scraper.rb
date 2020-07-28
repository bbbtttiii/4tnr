# Sole purpose is to access remote data

require_relative './mountain.rb'


require 'nokogiri'
require 'httparty'
require 'pry'
require 'open-uri'
require 'net/http'


class Scraper

    def self.get_page #returns a scraped array of mountain info
        page = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/List_of_Colorado_fourteeners"))
        @@list = []
        
        page.css(".wikitable").each do |item|
            rank = item.css("td:nth-of-type(1)")
            name = item.css("td:nth-of-type(2) a[title]")
            range = item.css("td:nth-of-type(3) a[title]")
            elevation = item.css("td:nth-of-type(4)")
            location = item.css("td span.geo-dec")
            stats = {
                :rank => rank,
                :name => name.text.strip,
                :range => range,
                :elevation => elevation,
                :location => location
            }
            
            @@list << stats
        end
        @@list
    end
    # binding.pry
end 



#needs to produce a nested array containing mountain info
# list = [
#     1 = {
#         name: Mount Elbert,
#         range: Sawatch Range,
#         height: 14440 feet,
#         location: xxxxxxxxxx
#     }
#     2 = {
#         name: Mount Massive,
#         ....
#     }
# ]