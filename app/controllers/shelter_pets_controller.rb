class ShelterPetsController < ApplicationController

  def index
    @shelter = Shelter.find(params[:shelter_id])
    if params[:sort] == "only_adoptable"
      @pets = @shelter.pets.where(status: true)
    elsif params[:sort] == "only_pending"
      @pets = @shelter.pets.where(status: false)
    else
      @pets = @shelter.pets
    end
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    pet = shelter.pets.new(shelter_pets_params)
    if pet.save
      redirect_to "/shelters/#{shelter.id}/pets"
    end
  end

  def destroy

    shelter = Shelter.find(params[:shelter_id])
    pet = Pet.find(params[:pet_id])
    pet.destroy
    redirect_to "/shelters/#{shelter.id}/pets"
  end

  private

  def shelter_pets_params
    params.permit(:name, :image, :description, :age, :sex)
  end

end
