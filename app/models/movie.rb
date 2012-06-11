class Movie < ActiveRecord::Base

  RATINGS = ['G','PG','PG-13','R']

  def self.ratings
   return RATINGS
  end

end
