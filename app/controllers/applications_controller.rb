class ApplicationsController < ApplicationController

  def new
    @pets = favorites.selection_form_ready
  end

  def create
    pets = Pet.where(id: params[:pets])
    application = Application.new(application_params)
    if application.save
      pets.each do |pet|
        ApplicationPet.create(pet_id: pet.id, application_id: application.id)
        favorites.contents.delete(pet.id.to_s)
      end
      flash[:success] = "Your application for #{(pets.map{|pet| pet.name}.join(", "))} has been received."
      redirect_to "/favorites"
    end
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :description)
  end
end
