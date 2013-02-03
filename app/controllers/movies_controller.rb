class MoviesController < ApplicationController



  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index

     @all_ratings = Movie.all_ratings

     if params[:ratings]
       @raits = params[:ratings].to_a.flatten.uniq
     
     elsif !params[:ratings] && session[:ratings]

       @raits = session[:ratings].to_a.flatten.uniq
     
    else

       @raits = @all_ratings
     end
 # binding.pry  

    if (session[:sort] == "title" && params[:sort] == nil) || params[:sort] == "title"
    
         @movies = Movie.order("title").where(rating: @raits)
         @title_header = 'hilite'
         session[:sort] = "title"

    
    elsif (session[:sort] == "release_date" && params[:sort] == nil) || params[:sort] == "release_date"
      
         @movies = Movie.order("release_date").where(rating: @raits)
         @date_header = 'hilite'
         session[:sort] = "release_date"
    else
    
         @movies = Movie.where(rating: @raits)
     
    end
    session[:ratings] = params[:ratings]
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

end
