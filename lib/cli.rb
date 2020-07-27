# Handles interaction with the user, serves as middleman between API and model class(es)
# Only class that should have puts and gets


class CLI

    def run
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

        if input.downcase == "list"
            initial_list
        elsif input.downcase == "quit"
            quit
        elsif input.downcase == ""
        else
            puts "Sorry, I couldn't find that!"
        end

    end

    def initial_list
        Scraper.new.get_page
        Mountain.all.each_with_index do |mountain|
            puts "Name: #{mountain.name}"
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





    def find_by_name(name)
        Mountain.all.find{|mountain| mountain.name == name}
    end

    def quit
        "Goodbye!"
    end


end