class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if !params[:sort]
      flash.keep
      redirect_to :action => 'index', :sort => session[:sort] ? session[:sort] : 'none', :ratings => params[:ratings]
    elsif !params[:ratings]
      flash.keep
      redirect_to :action => 'index', :sort => params[:sort], :ratings => session[:ratings] ? session[:ratings] : 'none'
    else
      session[:sort] = params[:sort]
      session[:ratings] = params[:ratings]

      @movies = Movie.find(:all, :conditions => {:rating => session[:ratings] != 'none' ? session[:ratings].keys : nil}, :order => session[:sort] != 'none' ? session[:sort] : nil)
      @all_ratings = Movie.ratings
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

end
