class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  def other_movies_by_director
    Movie.where(:director => self.director) if (not self.director.nil?) and (not self.director.empty?)
  end
end
