class ReviewsController < ApplicationController

  def index
    # this is our list page for out reviews
    @reviews = Review.all
  end

  def new
    # The form for adding a new review
    @review = Review.new
  end

  def create
    #take the info from the form and adds it to the model
    @review = Review.new(form_params)
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
    #destroy
    @review.destroy
    #redirect to home page
    redirect_to root_path
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(form_params)
    # redirect to home page
      redirect_to review_path(@review)
    else
      render 'edit'
    end
  end

  def form_params
    params.require(:review).permit(:title, :body, :score)
  end
end
