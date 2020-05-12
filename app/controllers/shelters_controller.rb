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
    shelter = Shelter.find(params[:id])
    shelter.update(shelter_params)
    redirect_to "/shelters/#{shelter.id}"
  end

  def create
    shelter = Shelter.new(shelter_params)
    if shelter.save
      redirect_to '/shelters'
      flash[:success] = "#{shelter.name} has been added to the system!"
    elsif shelter.errors.full_messages == ["Name has already been taken"]
      flash[:error] = "Name is already in the system"
      render 'new'
    else
      flash[:error] = "All fields are required"
      render 'new'
    end
  end

  def destroy
    shelter = Shelter.find(params[:id])
    shelter.delete
    redirect_to "/shelters"
  end

  private
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end

end
