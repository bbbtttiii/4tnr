require_relative './mountain.rb'

class Scraper

    def self.get_page #returns a scraped array of mountain info
        url = "https://en.wikipedia.org/wiki/List_of_Colorado_fourteeners"
        page = Nokogiri::HTML(open(url))
        list = []
        
        page.css(".wikitable tbody tr").each do |item|
            # binding.pry
            rank = item.css("td:nth-of-type(1)").text.strip
            name = item.css("td:nth-of-type(2) a[title]").text
            range = item.css("td:nth-of-type(3) a[title]").text
            elevation = item.css("td:nth-of-type(4)").text.gsub!(/.*?(?=m)[m]/im, "")
            prominence = item.css("td:nth-of-type(5)").text.gsub!(/.*?(?=m)[m]/im, "")
            location = item.css("td span.geo-dec").text
            # lat = item.css("td span.geo-dec").text.split("°")[0]
            # long = item.css("td span.geo-dec").text.gsub!(/\s.+/im, "")
            mtn_url = item.css("td:nth-of-type(2) a[title]").attribute("href").to_s
            stats = {
                :rank => rank,
                :name => name,
                :range => range,
                :elevation => elevation,
                :prominence => prominence,
                :location => location,
                # :lat => lat,
                # :long => long,
                :mtn_url => mtn_url,
            }
            # binding.pry
            list << stats

            # mtn_page = url + mountain.mtn_url
            # stats[:bio] = mtn_page.css("p").first

        end
        list
    end

    # def self.get_bio(mountain)
        
    #     data = {}
    #     url = "https://en.wikipedia.org/wiki/List_of_Colorado_fourteeners"
    #     mtn_page = Nokogiri::HTML(open(url + mountain.mtn_url))
    #     stats[:bio] = mtn_page.css("p").first
    #     data
    # end


    # def get_weather

    #     response = HTTParty.get("api.openweathermap.org/data/2.5/weather?lat={"+lat+"}&lon={"+lon+"}&appid={0c18824544d24985b26a355b41a3601b}")
        
    # end
    
end