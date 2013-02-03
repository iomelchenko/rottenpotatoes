class Movie < ActiveRecord::Base
 
  def self.all_ratings
    allRatings = []
    Movie.all.each do |movie|
      if (allRatings.find_index(movie.rating) == nil)
        allRatings.push(movie.rating)
      end
    end
    return allRatings
  end




 # def self.all_ratings(val)
 #   allRatings = Array.new
 #   if val == nil
 #   	val = []
 #   end	
 #   val.each { |k, v|
 #     if allRatings and allRatings.length > 0
 #       allRatings &= Movie.filtered(val[k])
 #     else
 #       allRatings =Movie.filtered(val[k])
 #     end
  #  }
 #   return allRatings
 # end


end
