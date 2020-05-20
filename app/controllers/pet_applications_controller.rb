class PetApplicationsController < ApplicationController

  def index
    @pet = Pet.find(params[:pet_id])
    if @pet.applications == []
      flash[:notice] = "There aren't any current applications for #{@pet.name}."
    end
  end

  def update
    application = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])
    pet.update(status: false)
    pet.update(hold_for: "#{pet.name} is being held for #{application.name}")
    redirect_to "/pets/#{pet.id}"
  end
end
