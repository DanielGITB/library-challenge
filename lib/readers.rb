require 'yaml'
require './lib/library.rb'
require 'date'

class Reader
    def look_at_books
    @collection_books.select {|b| b[:available]}
    return @collection_books {|b| b[:title] [:author]}
end
#attempt
    
        
    
