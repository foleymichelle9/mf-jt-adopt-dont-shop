class PetsController < ApplicationController

  def index
    if params[:sort] == "adoptable_pets"
      @pets = Pet.order(:status).reverse
    elsif params[:sort] == "only_adoptable"
      @pets = Pet.where(status: true)
    elsif params[:sort] == "only_pending"
      @pets = Pet.where(status: false)
    else
      @pets = Pet.all
    end
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:id])
    pet.delete
    redirect_to "/pets"
  end

  def adoptable
    pet = Pet.find(params[:id])
    pet.status = false
    pet.save
    redirect_to "/pets/#{pet.id}"
  end

  def pending
    pet = Pet.find(params[:id])
    pet.status = true
    pet.save
    redirect_to "/pets/#{pet.id}"
  end

  private

  def pet_params
    params.permit(:name, :image, :description, :sex, :age)
  end
end
