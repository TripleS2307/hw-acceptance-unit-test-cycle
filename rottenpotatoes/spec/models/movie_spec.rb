require 'rails_helper'

RSpec.describe Movie, type: :model do
    context 'validation tests' do
        it 'ensures movie title presence' do
            movie = Movie.new(title: 'title').save
            expect(movie).to eq(true)
        end
        it 'ensures movie rating presence' do
            movie = Movie.new(rating: 'rating').save
            expect(movie).to eq(true)
        end
        it 'ensures movie description presence' do
            movie = Movie.new(description: 'description').save
            expect(movie).to eq(true)
        end
        it 'ensures movie release date presence' do
            movie = Movie.new(release_date: 'release_date').save
            expect(movie).to eq(true)
        end
        it 'ensures movie director presence' do
            movie = Movie.new(director: 'director').save
            expect(movie).to eq(true)
        end
    end
    describe '.find_similar_movies' do
    let!(:movie1) { FactoryGirl.create(:movie, title: 'Catch me if you can', director: 'Steven Spielberg') }
    let!(:movie2) { FactoryGirl.create(:movie, title: 'Seven', director: 'David Fincher') }
    let!(:movie3) { FactoryGirl.create(:movie, title: "Schindler's List", director: 'Steven Spielberg') }
    let!(:movie4) { FactoryGirl.create(:movie, title: "Stop") }

    context 'director exists' do
      it 'finds similar movies correctly' do
        expect(Movie.find_all_by_director(movie1.director, movie1.title)).to eql(['Catch me if you can', "Schindler's List"])
        expect(Movie.find_all_by_director(movie1.director, movie1.title)).to_not include(['Seven'])
        expect(Movie.find_all_by_director(movie2.director, movie2.title)).to eql(['Seven'])
      end
    end

    context 'director does not exist' do
      it 'handles sad path' do
        expect(Movie.find_all_by_director(movie4.director, movie4.title)).to eql(nil)
      end
    end
  end

  describe '.all_ratings' do
    it 'returns all ratings' do
      expect(Movie.all_ratings).to match(%w(G PG PG-13 NC-17 R))
    end
  end
end
