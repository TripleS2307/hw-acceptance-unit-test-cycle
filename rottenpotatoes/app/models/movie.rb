class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  def self.find_all_by_director dir, tlt
    Movie.where(:director => dir).where.not(:title => tlt)
  end
end