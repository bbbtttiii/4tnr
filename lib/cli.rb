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
                print_list
            elsif input.downcase == "quit"
                quit
            else
                not_found
                menu
            end
        # end
    end

    def print_list
        Mountain.all.each do |mountain|
            if mountain.rank.to_i > 0
                puts "##{mountain.rank.to_i}) #{mountain.name}"
            end 
        end
        puts ""
        puts "Enter a number:".colorize(:green)
        puts ""

        input = gets.strip
        
        if input.downcase == "quit"
            quit
        elsif input.to_i <= 53
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
        puts "Range:".colorize(:magenta) + " #{mountain.range}"
        puts "Location:".colorize(:magenta) + " #{mountain.location}"
        puts ""
        puts "-To go back to the list, enter 'list'".colorize(:green)
        puts "-To exit, enter 'quit'".colorize(:green)

        input = gets.strip

        if input.downcase == "back"
            print_list
        elsif input.downcase == "quit"
            quit
        else
            invalid_input
        end
    end

    # def search
    #     @@all.grep(/#{input}/)
    # end

    # def valid_mountain
    #     Mountain.all.any?{|num| num == input}
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



    # def print_list_2
    #     Mountain.all.each do |mtn|
    #         if mtn.rank.to_i > 17 && mtn.rank.to_i < 36
    #             puts "##{mtn.rank}) #{mtn.name}"
    #         end
    #     end
    #     puts ""
    #     puts "To see more, enter 'next'"
    #     input = gets.strip
    #     if input == "next"
    #         print_list_3
    #     end
    # end

    # def print_list_3
    #     Mountain.all.each do |mtn|
    #         if mtn.rank.to_i > 35 
    #             puts "##{mtn.rank}) #{mtn.name}"
    #         end
    #     end
    #     puts ""
    #     input = gets.strip
    #     if input == "next"
    #         puts "End of list!"
    #         menu
    #     end
    # end
