class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # form_tag workarounds
    params[:utf8] = nil
    params[:commit] = nil

    if params[:orderBy]=="movie"
       session[:orderBy] = "movie"
    elsif params[:orderBy]=="release_date"
       session[:orderBy] = "release_date"
    end
    
    if session[:orderBy]=="movie"
       @movies = Movie.find(:all, :order=>"title ASC")
       @highlighted="movie"   
    elsif session[:orderBy]=="release_date"
       @movies = Movie.find(:all, :order=>"release_date ASC")
       @highlighted="date"
    else
       @movies = Movie.all
    end
    # update the params hash (for redirection later)
    params[:orderBy] = session[:orderBy]

    # retrieve a new list of ratings
    @all_ratings = self.ratings
    # if rating boxes are checked get the list of checked ratings
    session[:ratings] = params[:ratings] if !params[:ratings].nil?
    params[:ratings] = session[:ratings]
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
    if (movies_path(params) != session[:url])
       session[:url] = movies_path(params)
       redirect_to movies_path(params)
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
