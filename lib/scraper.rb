class Scraper

    def self.get_page
        url = "https://en.wikipedia.org/wiki/List_of_Colorado_fourteeners"
        page = Nokogiri::HTML(open(url))
        list = []
        
        page.css(".wikitable tbody tr").each.with_index do |item|
            rank = item.css("td:nth-of-type(1)").text.strip
            name = item.css("td:nth-of-type(2) a[title]").text
            range = item.css("td:nth-of-type(3) a[title]").text
            elevation = item.css("td:nth-of-type(4)").text.gsub!(/.*?(?=m)[m]/im, "")
            prominence = item.css("td:nth-of-type(5)").text.gsub!(/.*?(?=m)[m]/im, "")
            location = item.css("td span.geo-dec").text
            lat = item.css("td span.geo-dec").text.split("°")[0]
            long = item.css("td span.geo-dec").text.match(/(?<=\s).*[\d]/).to_s
            mtn_url = item.css("td:nth-of-type(2) a[title]").attribute("href").to_s
            stats = {
                :rank => rank,
                :name => name,
                :range => range,
                :elevation => elevation,
                :prominence => prominence,
                :location => location,
                :lat => lat,
                :long => long,
                :mtn_url => mtn_url
            }
            list << stats
        end
        list
    end

    def self.get_bio(mtn_url)
        bios = {}
        base_url = "https://en.wikipedia.org"
        mtn_page = Nokogiri::HTML(open(base_url + mtn_url))
        bios[:bio] = mtn_page.css("p:nth-of-type(1), p:nth-of-type(2)").text
        bios
    end

end