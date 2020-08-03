class Scraper

    #class method
    #iterates through the wikipedia table and returns an array "list" of attributes in key/val pairs
    def self.get_page
        url = "https://en.wikipedia.org/wiki/List_of_Colorado_fourteeners"
        page = Nokogiri::HTML(open(url))
        list = []
        
        #iterate through each tr element in the table, assigning attributes variables to certain tds
        page.css(".wikitable tbody tr").each.with_index do |item|
            rank = item.css("td:nth-of-type(1)").text.strip
            name = item.css("td:nth-of-type(2) a[title]").text
            range = item.css("td:nth-of-type(3) a[title]").text
            elevation = item.css("td:nth-of-type(4)").text.gsub(/.*?(?=m)[m]/im, "")
            prominence = item.css("td:nth-of-type(5)").text.gsub(/.*?(?=m)[m]/im, "")
            location = item.css("td span.geo-dec").text
            mtn_url = item.css("td:nth-of-type(2) a[title]").attribute("href").to_s
            #assign the variables as hash values to hash key symbols
            stats = {
                :rank => rank,
                :name => name,
                :range => range,
                :elevation => elevation,
                :prominence => prominence,
                :location => location,
                :mtn_url => mtn_url
            }
            #adds the hash to the empty list array
            list << stats
        end
        #returns the list array
        list
    end

    #class method
    #takes in mtn_url as argument which is used to identify the wiki to scrape
    #adds the paragraphs from a mountain's wiki to the "bios" hash, assigning it to "bio" key
    def self.get_bio(mtn_url)
        bio_hash = {}
        base_url = "https://en.wikipedia.org"
        mtn_page = Nokogiri::HTML(open(base_url + mtn_url))
        bio_hash[:bio] = mtn_page.css("p:nth-of-type(1), p:nth-of-type(2)").text.gsub(/\[.*?\]/, "")
    end

end