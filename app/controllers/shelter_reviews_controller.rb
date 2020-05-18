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
      if review.errors.full_messages == ["Content can't be blank"]
        flash[:error] = "Please fill out a short message regarding your experience with #{@shelter.name}"
      else
        flash[:error] =  "All fields must be filled in."
      end
      render :new
    end
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    @review = Review.find(params[:review_id])
    if @review.update(shelter_review_params)
      flash[:success]= "#{@review.title} has been updated."
      redirect_to "/shelters/#{@review.shelter.id}"
    else
      flash[:error] = "Please fill in all fields."
      render 'edit'
    end
  end

  def destroy
    review = Review.find(params[:review_id])
    review.delete
    redirect_to "/shelters/#{review.shelter.id}"
  end

  private
  def shelter_review_params
    params.permit(:title, :image, :rating, :content)
  end
end
