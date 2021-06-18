class CLI 

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
    puts "     (Loading, please wait...)"
    scrape_page
    greeting
    menu
  end

  def menu
    puts ""
    puts "-To see all mountains, enter 'list'".colorize(:green)
    puts "-To view the resources page, enter 'links'".colorize(:green)
    puts "-To exit, enter 'quit'".colorize(:green)

    input = gets.strip
    if input.downcase == "list"
      print_1_to_19
    elsif input.downcase == "links"
      links_page
    elsif input.downcase == "quit"
      quit
    #if mountain is valid, call find method on mountain class based on user's input
    #then use that input to create the mountain page
    elsif input.to_i > 0 && input.to_i <= 53
      mountain = Mountain.search(input.to_i)
      mountain_page(mountain)
    else
      not_found
      menu
    end
  end

  def print_1_to_19
    puts ""
    Mountain.all.each do |mountain|
      if mountain.rank.to_i >= 1 && mountain.rank.to_i <= 19
        puts "##{mountain.rank.to_i}) #{mountain.name}"
      end 
    end

    puts "..."
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
    elsif input.downcase == "links"
      links_page
    elsif input.downcase == "list"
      print_1_to_19
    elsif input.to_i >= 1 && input.to_i <= 53
      mountain = Mountain.search(input.to_i)
      mountain_page(mountain)
    else
      not_found
      menu
    end
  end

  def print_20_to_39
    puts ""
    Mountain.all.each do |mountain|
        if mountain.rank.to_i >= 20 && mountain.rank.to_i <= 39
            puts "##{mountain.rank.to_i}) #{mountain.name}"
        end 
    end

    puts "..."
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
    elsif input.downcase == "links"
      links_page
    elsif input.downcase == "back"
      print_1_to_19
    elsif input.to_i >= 1 && input.to_i <= 53
      mountain = Mountain.search(input.to_i)
      mountain_page(mountain)
    else
      not_found
      menu
    end
  end

  def print_40_to_53
    puts ""
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
    elsif input.downcase == "links"
      links_page
    elsif input.downcase == "back"
      print_20_to_39
    elsif input.downcase == "next"
      puts "End of list!".colorize(:magenta)
      menu
    elsif input.to_i >= 1 && input.to_i <= 53
      mountain = Mountain.search(input.to_i)
      mountain_page(mountain)
    else
      not_found
      menu
    end
  end

  def mountain_page(mountain)
    puts ""
    puts ""
    puts "##{mountain.rank.to_i}".colorize(:light_blue) + "   #{mountain.name}".colorize(:light_blue)
    puts ""
    puts "     Elevation:".colorize(:magenta) + " #{mountain.elevation}"
    puts "     Prominence:".colorize(:magenta) + " #{mountain.prominence}"
    puts "     Range:".colorize(:magenta) + " #{mountain.range}"
    puts "     Location:".colorize(:magenta) + " #{mountain.location}"
    puts "     _______________________________"
    puts ""
    puts "     About #{mountain.name}".colorize(:light_yellow)
    puts ""
    puts "     #{add_bio(mountain)}"
    puts ""
    puts "-To go back to the list, enter 'back'".colorize(:green)
    puts "-To view the resources page, enter 'links'".colorize(:green)
    puts "-To exit, enter 'quit'".colorize(:green)
    mountain_page_input(mountain)
  end

  def mountain_page_input(mountain)
    input = gets.strip
    if input.downcase == "back"
      if (mountain.rank.to_i >= 1 && mountain.rank.to_i <= 19)
        print_1_to_19
      elsif (mountain.rank.to_i >= 20 && mountain.rank.to_i <= 39)
        print_20_to_39
      elsif (mountain.rank.to_i >= 40 && mountain.rank.to_i <=53)
        print_40_to_53
      end
    elsif input.downcase == "quit"
      quit
    elsif input.downcase == "links"
      links_page
    else
      invalid_input
      menu
    end
  end

  def scrape_page
    info = Scraper.get_page
    Mountain.create_from_scrape(info)
  end

  #calls get_bio method on Scraper class, taking in a mountain with its url as an arg
  def add_bio(mountain)
    Scraper.get_bio(mountain.mtn_url)
  end

  def greeting
    puts ""
    puts "Hi! What's your name?".colorize(:magenta)
    input = gets.strip
    puts "Welcome to 4TNR, #{input}.".colorize(:green)
  end

  def links_page
    puts ""
    puts "-------------------".colorize(:light_yellow)
    puts "| Further Reading |".colorize(:light_yellow)
    puts "-------------------".colorize(:light_yellow)
    puts ""
    puts "Photo gallery of popular 14ers:" + "      https://en.wikipedia.org/wiki/List_of_Colorado_fourteeners#gallery".colorize(:light_blue)
    puts "Map of all listed mountains:" + "         https://osm4wiki.toolforge.org/cgi-bin/wiki/wiki-osm.pl?project=en&article=List_of_Colorado_fourteeners".colorize(:light_blue)
    puts "Popular hiking routes:" + "               https://www.14ers.com/routes.php".colorize(:light_blue)
    puts ""
    puts "To go back to the menu, enter 'back'".colorize(:green)

    input = gets.strip
    if input.downcase == "back"
      menu
    elsif input.downcase == "quit"
      quit
    else
      invalid_input
      menu
    end
  end

  def not_found
    puts "Sorry, I couldn't find that."
  end

  def invalid_input
    puts "Sorry, I didn't understand that."
  end

  def quit
    puts ""
    puts "Goodbye!".colorize(:red)
    puts ""
  end

end