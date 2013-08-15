class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    initial_path = movies_path(params)
    if params[:order_by]=="movie"
       session[:order_by] = "movie"
    elsif params[:order_by]=="release_date"
       session[:order_by] = "release_date"
    end
    
    if session[:order_by]=="movie"
       @movies = Movie.find(:all, :order=>"title ASC")
       @highlighted="movie"   
    elsif session[:order_by]=="release_date"
       @movies = Movie.find(:all, :order=>"release_date ASC")
       @highlighted="date"
    else
       @movies = Movie.all
    end
    # update the params hash (for redirection later)
    params[:order_by] = session[:order_by]

    # retrieve a new list of ratings
    @all_ratings = self.ratings
    # if rating boxes are checked get the list of checked ratings
    session[:ratings] = params[:ratings] if !params[:ratings].nil?
    if session[:ratings]
       @applicable_ratings = session[:ratings].keys

       new_movie_list = Array.new
       @movies.each do |movie|
          # filter movies
          if (@applicable_ratings.include? movie[:rating])
             new_movie_list.push movie
          end
       end
       @movies = new_movie_list
    end
    # Only fill the params with ratings if not all are selected. Otherwise leave out
    if (params[:ratings] == nil and session[:ratings] == nil) or (@all_ratings == @applicable_ratings)
       params[:ratings] = nil
    else
       params[:ratings] = session[:ratings]
    end
    # form_tag workarounds
    params[:utf8] = nil
    params[:commit] = nil

    if ((movies_path(params) != initial_path) and (movies_path(params) != session[:url]))
       session[:url] = movies_path(params)
       redirect_to movies_path(params)
    else
       session[:url] = nil
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  def ratings
    ratings = Array.new
    movies = Movie.all
    movies.each do |movie|
       ratings.push movie[:rating]
       ratings.uniq!
    end
    return ratings
  end
end
