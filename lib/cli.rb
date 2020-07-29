class CLI 

    def run
        input = nil
        puts ""
        puts "    _  _ _____ _   _ ____      ".colorize(:light_blue)
        puts "   | || |_   _| \\ | |  _ \\   ".colorize(:light_blue)
        puts "   | || |_| | |  \\| | |_| |   ".colorize(:light_blue)
        puts "   |__   _| | | |\\  |  _ <    ".colorize(:light_blue)
        puts "      |_| |_| |_| \\_|_| \\_\\ ".colorize(:light_blue)
        puts ""
        puts "4TNR: A Colorado Fourteeners Guide".colorize(:light_blue)
        scrape
        menu
    end

    def menu
        puts ""
        puts "-To see all mountains, enter 'list'".colorize(:green)
        # puts "-To go to a specific mountain, enter it below!".colorize(:green)
        puts "-To exit, enter 'quit'".colorize(:green)

        input = gets.strip

        # if input.to_i == valid_mountain  #find_by_name search
        #     mountain_page
        # else
            if input.downcase == "list"
                print_1_to_19
            elsif input.downcase == "quit"
                quit
            elsif input.to_i > 0 && input.to_i <= 53
                mountain = Mountain.find(input.to_i)
                mountain_page(mountain)
            else
                not_found
                menu
            end
        # end
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
        puts "Elevation:".colorize(:magenta) + " #{mountain.elevation}"
        puts "Prominence:".colorize(:magenta) + " #{mountain.prominence}"
        puts "Range:".colorize(:magenta) + " #{mountain.range}"
        puts "Location:".colorize(:magenta) + " #{mountain.location}"
        puts ""
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
        else
            invalid_input
            menu
        end
    end

    # def search
    #     @@all.grep(/#{input}/)
    # end

    def scrape 
        array = Scraper.get_page
        Mountain.create_from_scrape(array)
        # binding.pry
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

end

