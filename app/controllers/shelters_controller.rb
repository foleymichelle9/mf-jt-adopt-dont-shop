class SheltersController < ApplicationController

  def index
    if params[:sort] == "shelters_alphabetical"
      @shelters = Shelter.order(name: :asc)
    elsif params[:sort] == "num_pets"
      @shelters = Shelter.num_pets_desc
    else
      @shelters = Shelter.all
    end
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new
  end

  def edit
    @shelter= Shelter.find(params[:id])
  end

  def update
    @shelter = Shelter.find(params[:id])
    if @shelter.update(shelter_params)
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:error] = @shelter.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def create
    shelter = Shelter.new(shelter_params)
    if shelter.save
      redirect_to '/shelters'
      flash[:success] = "#{shelter.name} has been added to the system!"
    elsif shelter.errors.full_messages == ["Name has already been taken"]
      flash[:error] = "Name is already in the system"
      render 'new'
    elsif
      flash[:error] = shelter.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def destroy
    shelter = Shelter.find(params[:id])
    if shelter.pets.where(status: :false).exists?
      flash[:error] = "Pet pending adoption, shelter can not be deleted."
    else
    shelter.delete
    end
    redirect_to "/shelters"
  end

  private
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end

end
