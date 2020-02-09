require 'yaml'
require 'date'


class Library
    attr_accessor :collection_books, :available

    BORROWING_PERIOD_DAYS = 30
    
    def initialize
        @collection_books = YAML.load_file('./lib/data.yml')
    end
    #opens the yaml-file

    ## select, In this specific case, it will return the array of 
    ##all hashes which contain a true :available key. 

    def books_is_available?
        collection_books.select {|b| b[:available]}
    end
    #Lists all books that are available: true

    def books_is_unavailable?
        collection_books.select {|b| b[:available].eql? false }
    end
    #Opposite of the one above

    def search_book_title(user_input)
        collection_books.select{|b| b[:item][:title].include? "#{user_input}"}
    end
    #Search function for the books title. 'include?' make sure the visitors input isnt translated to ==

    def search_book_author(user_input)
        collection_books.select{|b| b[:item][:author].include? "#{user_input}"}
    end
    #Same as above but for the books author

    def borrow_period(num)
        @collection_books[(num)][:available] = false
        @collection_books[(num)][:return_date] = time_out
        File.open('./lib/data.yml', 'w') { |f| f.write @collection_books.to_yaml }
    end
    # 'num' is the input of book in the array.
    # It then changes the boolean to false, meaning the user borrowed.
    # Then it sets the return date to todays date + 30 days.
    # Lastly it saves the new information in the yaml-file.

    def return_book_date(num)    
        @collection_books[(num)][:available] = true
        @collection_books[(num)][:return_date] = nil
        File.open('./lib/data.yml', 'w') { |f| f.write @collection_books.to_yaml }
    end
    #Opposite of above. Boolean becomes true and the return date becomes nil since the book is returned

    def time_out
    Date.today + BORROWING_PERIOD_DAYS
    end
    # Timer for the borrowed book



private



