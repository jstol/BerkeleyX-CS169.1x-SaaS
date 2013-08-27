require "spec_helper"

describe Movie do
  it { should respond_to(:other_movies_by_director) }
  it { should respond_to(:director) }

  describe "retrieving a list of all movies by the same director" do
    context "when a director value is set" do
      before do
        # Set up the object and Movie class stub
        @movie = Movie.new
        @movie.director = "Director"
        @movies = ["Movie 1", "Movie 2", "Movie 3"]
        Movie.stub(:where).with(:director => @movie.director).and_return @movies
      end
      it "should retrieve the list of the director's movies" do
        @movie.other_movies_by_director.should == @movies
      end
    end
    context "when a director value is not set" do
      before do
        @movie = Movie.new
        @movie.director = nil
      end
      it "should return nil" do
        @movie.other_movies_by_director.should == nil
      end
    end
  end
end