class FavoritesController < ApplicationController

  def update
    pet = Pet.find(params[:pet_id])

    if favorites.contents.keys.include?(pet.id.to_s)
      flash[:notice] = "You have already favorited #{pet.name}"
      redirect_to "/pets/#{pet.id}"
    else
      favorites.add_pet(pet.id)
      session[:favorites] = @favorites.contents
      flash[:notice] = "You have added #{pet.name} to your favorites."
      redirect_to "/pets/#{pet.id}"
    end
  end

end