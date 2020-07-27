# Handles interaction with the user, serves as middleman between API and model class(es)
# Only class that should have puts and gets


class CLI

    def run
        puts "
         _  _ _____ _   _ ____       _
        | || |_   _| \\ | |  _ \\     /#\\
        | || |_| | |  \\| | |_| |   /###\\
        |__   _| | | |\\  |  _ <   /     \\
           |_| |_| |_| \\_|_| \\_\\ /.......\\        

        4TNR: A Colorado Fourteeners Guide

        -To see all mountains, enter LIST
        -To go to a specific mountain, enter it below!

        "
        input = gets.strip
        if input == "LIST" || input == "List" || input == "list"
            initial_list
        else
            puts "Sorry, I couldn't find that!"
        end

    end



    URL = "https://en.wikipedia.org/wiki/List_of_Colorado_fourteeners"

    def initial_list
        get_mtns
        print_all_mtns
    end

    def get_mtns
        mountain_array = Scraper.get_page(URL)
        Mountain.make_list(mountain_array)
    end

    def print_all_mtns
        Mountain.all.each_with_index do |mountain|
            puts "Name: #{mountain.name}"
        end
    end


end