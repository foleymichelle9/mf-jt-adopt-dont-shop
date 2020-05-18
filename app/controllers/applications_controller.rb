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
      flash[:success] = "Your application for #{(pets.map{|pet| pet.name}.join(" and "))} has been received."
      redirect_to "/favorites?page=fav"
    elsif application.errors.full_messages == ["Description can't be blank"]
      flash[:notice] = "Please let us know why you would like to adopt this pet."
      render :new
    elsif application.errors.full_messages == ["Name can't be blank"]
      flash[:notice] = "Please tell us your name so we can process your application"
      render :new
    else
      flash[:notice] = application.errors.full_messages.to_sentence
      render :new
    end
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :description)
  end
end
