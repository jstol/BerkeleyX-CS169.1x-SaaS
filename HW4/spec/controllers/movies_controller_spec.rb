require "spec_helper"

describe MoviesController do
  it { should respond_to(:same_director) }

  describe "searching for movies by the same director" do
   	context "when a 'Director' value is present" do
   		before do
        # Set up stub for Movie class' find method when given an ID of 0
   			@movie = mock("movie", {:id => "0", :director => "Steven Spielberg"})
        Movie.stub(:find).with("0").and_return @movie
        # Set up stub for movie object's other_movies_by_director method to return pre-defined list
   			@spielberg_films = ["E.T.", "Jaws", "War Horse", "Schindler's List"]
        @movie.stub(:other_movies_by_director).and_return @spielberg_films
   		end
      it "should set up the @director and @movies variables for the view" do
    	  get :same_director, :movie_id => @movie.id
        assigns(:director).should == @movie.director
        assigns(:movies).should == @spielberg_films
      end
      it "should render the view of movies by the director" do
        get :same_director, :movie_id => @movie.id
        response.should render_template :director
      end
   	end
    context "when a 'Director' value is not present" do
      before do
        # Set up a mock for a movie that has no director value
        @movie = mock("movie", {:id => "1", :title => "Fake Movie", :director => nil})
        Movie.stub(:find).with("1").and_return @movie
        @movie.stub(:other_movies_by_director).and_return(nil)
      end
      it "should redirect to the home page with a message saying that no movies exist" do
        get :same_director, :movie_id => 1
        flash[:notice].should == "'#{@movie.title}' has no director info"
        response.should redirect_to(root_path)
      end
    end
 	end
end