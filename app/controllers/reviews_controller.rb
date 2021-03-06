class ReviewsController < ApplicationController
  #check if logged in
  before_action :check_login, except: [:index, :show]

  def index
    # this is our list page for out reviews
    @price = params[:price]
    @cuisine = params[:cuisine]
    @location = params[:location]

    #start with all the Reviews
    @reviews = Review.all
    #filtering by prices
    if @price.present?
      @reviews = @reviews.where(price: @price)
    end
    #filtering by cuisine
    if @cuisine.present?
      @reviews = @reviews.where(cuisine: @cuisine)
    end
    #search near location
    if @location.present?
      @reviews = @reviews.near(@location)
    end
  end


  def new
    # The form for adding a new review
    @review = Review.new
  end

  def create
    #take the info from the form and adds it to the model
    @review = Review.new(form_params)
    #and then asscocaite with current user
    @review.user = @current_user
    #check if we can save
    if @review.save
    # if can be saved redirect to home page
      redirect_to root_path
    # else show new form again
    else
      render 'new'
    end
  end

  def show
    #idividual review page
    @review = Review.find(params[:id])
  end

  def destroy

    #find idividual review
    @review = Review.find(params[:id])
    #destroy if they have access
    if @review.user == @current_user
      @review.destroy
    end
    #redirect to home page
    redirect_to root_path
  end

  def edit
    @review = Review.find(params[:id])
    if @review.user != @current_user
      redirect_to root_path
    elsif @review.created_at < 1.hour.ago
      redirect_to review_path
    end
  end

  def update
    @review = Review.find(params[:id])
    if @review.user != @current_user
      redirect_to root_path
    else
      if @review.update(form_params)
      # redirect to home page
        redirect_to review_path(@review)
      else
        render 'edit'
      end
    end

  end

  def form_params
    params.require(:review).permit(:title, :restaurant,  :body, :cuisine, :price, :score, :ambiance, :address, :photo)
  end
end
