# Sole purpose is to access remote data

require 'nokogiri'
require 'open-uri'
require 'pry'

class API

    def get_page
        page = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/List_of_Colorado_fourteeners"))
   
        binding.pry
    end

end