# Handles interaction with the user, serves as middleman between API and model class(es)
# Only class that should have puts and gets


class CLI 

    def run
        initial_scrape
        start
    end


    def start

        puts "
         _  _ _____ _   _ ____    
        | || |_   _| \\ | |  _ \\  
        | || |_| | |  \\| | |_| |
        |__   _| | | |\\  |  _ <  
           |_| |_| |_| \\_|_| \\_\\ 

        4TNR: A Colorado Fourteeners Guide

        -To see all mountains, enter 'list'
        -To go to a specific mountain, enter it below!
        -To exit, enter 'quit'
        "

        input = gets.strip

        if input.downcase == "" #find_by_name search
            asdf
        else
            if input.downcase == "list"
                print_list
            elsif input.downcase == "quit"
                quit
            else
                puts "Sorry, I couldn't find that."
            end
        end

    end

    def initial_scrape
        array = Scraper.get_page
        Mountain.create_from_scrape(array)
    end

    def print_list
        Mountain.all.each do |mtn|
            puts "#{rank}) #{name}"
        end
    end

    def mountain_page
        puts "##{rank}) #{name}"
        puts "Elevation: #{elevation}"
        puts "Range: #{range}"
        puts "Location #{location}"
        puts ""
        puts "-To go back, enter 'back'"
        puts "-To exit, enter 'quit'"

        input = gets.strip

        if input.downcase == "back"
            run
        elsif input.downcase == "quit"
            quit
        end
    end







    def quit
        "Goodbye!"
    end


end