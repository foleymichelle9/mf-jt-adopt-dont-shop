class ShelterReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    review = @shelter.reviews.new(shelter_review_params)
    if review.save
      flash[:success] = "Your review of #{@shelter.name} has been saved"
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:error] = "All fields are required."
      render 'new'
    end
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    review = Review.find(params[:review_id])
    review.update(shelter_review_params)
    redirect_to "/shelters/#{review.shelter.id}"
  end

  private
  def shelter_review_params
    params.permit(:title, :image, :rating, :content)
  end
end
