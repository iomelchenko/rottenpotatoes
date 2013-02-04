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
    
         sorted = "title"
         @title_header = 'hilite'
    
    elsif (session[:sort] == "release_date" && params[:sort] == nil) || params[:sort] == "release_date"
      
         sorted = "release_date"
         @date_header = 'hilite'
    else
         sorted = 1
    
    end

#binding.pry 
        @movies = Movie.order(sorted).where(rating: @raits)
      if (session[:sort] != params[:sort] && params[:sort] != nil) || (session[:ratings] != params[:ratings] && params[:ratings] != nil)
      #if session[:sort] != params[:sort] || session[:ratings] != params[:ratings]        

        session[:sort] = sorted 
        session[:ratings] = params[:ratings] 
        
        #flash.keep
        #redirect_to movies_path(@movies)
        # redirect_to movies_path, :sort => sorted, :ratings => params[:ratings] #and return
        redirect_to movies_path(:sort => session[:sort], :ratings => session[:ratings])
      end
        
        #redirect_to movies_path(@movies)
        #redirect_to movies_path(:sort => sorted, :ratings => @raits) and return
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
