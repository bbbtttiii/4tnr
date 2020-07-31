class CLI 

    # URL = ""

    def run
        input = nil
        puts ""
        puts "     _  _ _____ _   _ ____      ".colorize(:light_blue)
        puts "    | || |_   _| \\ | |  _ \\   ".colorize(:light_blue)
        puts "    | || |_| | |  \\| | |_| |   ".colorize(:light_blue)
        puts "    |__   _| | | |\\  |  _ <    ".colorize(:light_blue)
        puts "       |_| |_| |_| \\_|_| \\_\\ ".colorize(:light_blue)
        puts ""
        puts "4TNR: A Colorado Fourteeners Guide".colorize(:light_yellow)
        puts ""
        loading
        scrape
        add_bios
        menu
        # get_weather
    end

    def menu
        puts ""
        puts "-To see all mountains, enter 'list'".colorize(:green)
        # puts "-To see your favorites, enter 'favorites'" unless favorites_hash.length == nil
        # puts "-To go to a specific mountain, enter it below!".colorize(:green)
        puts "-To exit, enter 'quit'".colorize(:green)

        input = gets.strip

            if input.downcase == "list"
                print_1_to_19
            elsif input.downcase == "quit"
                quit
            # elsif input.downcase == "favorites"
            #     print_favorites
            elsif input.to_i > 0 && input.to_i <= 53
                mountain = Mountain.find(input.to_i)
                mountain_page(mountain)
            else
                not_found
                menu
            end

    end

    def print_1_to_19
        Mountain.all.each do |mountain|
            if mountain.rank.to_i >= 1 && mountain.rank.to_i <= 19
                puts "##{mountain.rank.to_i}) #{mountain.name}"
            end 
        end

        puts ""
        puts "To see more, enter 'next'".colorize(:green)
        puts ""
        puts "Enter a number:".colorize(:green)
        puts ""

        input = gets.strip
        if input.downcase == "quit"
            quit
        elsif input.downcase == "next"
            print_20_to_39
        elsif input.downcase == "list"
            print_1_to_19
        elsif input.to_i >= 1 && input.to_i <= 53
            mountain = Mountain.find(input.to_i)
            mountain_page(mountain)
        else
            not_found
            menu
        end
    end

    def print_20_to_39
        Mountain.all.each do |mountain|
            if mountain.rank.to_i >= 20 && mountain.rank.to_i <= 39
                puts "##{mountain.rank.to_i}) #{mountain.name}"
            end 
        end
    
        puts ""
        puts "To see more, enter 'next'".colorize(:green)
        puts "To go back, enter 'back'".colorize(:green)
        puts ""
        puts "Enter a number:".colorize(:green)
        puts ""

        input = gets.strip
        if input.downcase == "quit"
            quit
        elsif input.downcase == "next"
            print_40_to_53
        elsif input.downcase == "back"
            print_1_to_19
        elsif input.to_i >= 1 && input.to_i <= 53
            mountain = Mountain.find(input.to_i)
            mountain_page(mountain)
        else
            not_found
            menu
        end
    end
    
    def print_40_to_53
        Mountain.all.each do |mountain|
            if mountain.rank.to_i > 39
                puts "##{mountain.rank.to_i}) #{mountain.name}"
            end 
        end
    
        puts ""
        puts "To go back, enter 'back'".colorize(:green)
        puts ""
        puts "Enter a number:".colorize(:green)
        puts ""
        
        input = gets.strip
        if input.downcase == "quit"
            quit
        elsif input.downcase == "back"
            print_20_to_39
        elsif input.downcase == "next"
            puts "End of list!"
            menu
        elsif input.to_i >= 1 && input.to_i <= 53
            mountain = Mountain.find(input.to_i)
            mountain_page(mountain)
        else
            not_found
            menu
        end
    end

    def mountain_page(mountain)
        puts ""
        puts "##{mountain.rank.to_i}:" + " #{mountain.name}".colorize(:light_blue)
        puts ""
        puts "      Elevation:".colorize(:magenta) + " #{mountain.elevation}"
        puts "      Prominence:".colorize(:magenta) + " #{mountain.prominence}"
        puts "      Range:".colorize(:magenta) + " #{mountain.range}"
        puts "      Location:".colorize(:magenta) + " #{mountain.location}"
        puts "      Lat: #{mountain.lat}"
        puts "      Long: #{mountain.long}"
        # print_wx
        puts ""
        puts "      #{mountain.bio}".gsub(/\[.*?\]/, "")
        puts ""
        # puts "-To add to favorites, enter 'add'"
        # puts "-To view favorites, enter 'favorites'"
        puts "-To go back to the list, enter 'list'".colorize(:green)
        puts "-To exit, enter 'quit'".colorize(:green)

        input = gets.strip
        if input.downcase == "list"
            if (mountain.rank.to_i >= 1 && mountain.rank.to_i <= 19)
                print_1_to_19
            elsif (mountain.rank.to_i >= 20 && mountain.rank.to_i <= 39)
                print_20_to_39
            elsif (mountain.rank.to_i >= 40 && mountain.rank.to_i <=53)
                print_40_to_53
            end
        elsif input.downcase == "quit"
            quit
        # elsif input.downcase == "add"
        #     if favorites_hash.length == nil
        #         puts "Favorites are empty!"
        #     else
        #         ????
        #     end
        # elsif input.downcase == "favorites"
        #     print_favorites
        else
            invalid_input
            menu
        end
    end

    def scrape
        info = Scraper.get_page
        Mountain.create_from_scrape(info)
        # binding.pry
    end

    def add_bios
        # binding.pry
        Mountain.all.each do |mountain|
          attributes = Scraper.get_bio(mountain.mtn_url)
          mountain.add_mtn_bio(attributes)
        end
    end

    def not_found
        puts "Sorry, I couldn't find that."
    end

    def invalid_input
        puts "Sorry, I didn't understand that."
    end

    def quit
       puts "Goodbye!".colorize(:red)
    end

    # def get_weather(lat, long)
    #     hash = Scraper.get_weather(lat, long)
    #     Mountain.new(hash)
    # end

    # def print_wx(lat, long)
        
    # end

    def loading
        spinner = Enumerator.new do |e|
            loop do
              e.yield '|'
              e.yield '/'
              e.yield '-'
              e.yield '\\'
            end
          end
          
          1.upto(100) do |i|
            printf("\rLoading... %s", spinner.next)
            sleep(0.1)
          end
    end

end

