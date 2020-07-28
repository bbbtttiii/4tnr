# Handles interaction with the user, serves as middleman between API and model class(es)
# Only class that should have puts and gets


class CLI 

    def run
        input = nil
        puts ""
        puts "    _  _ _____ _   _ ____      "
        puts "   | || |_   _| \\ | |  _ \\   "
        puts "   | || |_| | |  \\| | |_| |   "
        puts "   |__   _| | | |\\  |  _ <    "
        puts "      |_| |_| |_| \\_|_| \\_\\ "
        puts ""
        puts "4TNR: A Colorado Fourteeners Guide"

        scrape
        start
    end

    def start

        puts ""
        puts "-To see all mountains, enter 'list'"
        puts "-To go to a specific mountain, enter it below!"
        puts "-To exit, enter 'quit'"

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
                start
            end
        end

    end

    def scrape
        array = Scraper.get_page
        Mountain.create_from_scrape(array)
    end

    def print_list
        Mountain.all.each do |mtn, rank|
            puts "##{rank}) #{mtn}"
        end
    end

    def mountain_page
        puts "##{rank}) #{name}"
        puts ""
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
        else
            puts "Sorry, I didn't understand that."
        end
    end







    def quit
       puts "Goodbye!"
    end


end