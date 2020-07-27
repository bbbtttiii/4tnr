# Handles interaction with the user, serves as middleman between API and model class(es)
# Only class that should have puts and gets


class CLI

    puts "
 _  _ _____ _   _ ____       _
| || |_   _| \\ | |  _ \\     /#\\
| || |_| | |  \\| | |_| |   /###\\
|__   _| | | |\\  |  _ <   /     \\
   |_| |_| |_| \\_|_| \\_\\ /.......\\        

4TNR: A Colorado Fourteeners Guide

-To list all mountains, enter LIST
-To go to a specific mountain, enter it below!

"

    def run
        Scraper.list
    end

    def start
        #prints all mtns
        mountains.each_with_index do |item, index|
            puts "#{index+1}) #{item.text.strip}"
        end
    end


end