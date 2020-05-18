class FavoritesController < ApplicationController

  def index
    @favorite_pets = favorites.favorite_pets
    if params[:page] == "fav"
      flash[:notice] = "You have cleared your list of favorites."
    elsif params[:page].nil? && @favorite_pets == []
      flash[:notice] = "You have not favorited any pets"
      redirect_to "/pets"
    end
  end

  def update
    pet = Pet.find(params[:pet_id])
    favorites.add_pet(pet.id)
    session[:favorites] = @favorites.contents
    flash[:notice] = "You have added #{pet.name} to your favorites."
    redirect_to "/pets/#{pet.id}"
  end

  def remove_one
    pet = Pet.find(params[:pet_id])
    favorites.contents.delete(pet.id.to_s)
    flash[:notice] = "You have removed #{pet.name} from favorites"
    if params[:direction] == "show"
      redirect_to "/pets/#{pet.id}"
    else
      redirect_to "/favorites"
    end 
  end

  def destroy
    favorites.delete_all
    flash[:notice] = "You have cleared your list of favorites."
    redirect_to "/favorites?page=fav"
  end

  # def destroy
  #   require "pry"; binding.pry
  #   if favorites.contents.count == 1
  #     pet = Pet.find(params[:pet_id])
  #     favorites.contents.delete(pet.id.to_s)
  #     flash[:notice] = "You have removed #{pet.name} from favorites"
  #   end
  #
  #   if favorites.contents.count > 1
  #     favorites.delete_all
  #     flash[:notice] = "You have cleared your list of favorites."
  #     redirect_to "/favorites"
  #   else
  #     pet = Pet.find(params[:pet_id])
  #     favorites.contents.delete(pet.id.to_s)
  #     flash[:notice] = "You have removed #{pet.name} from favorites"
  #     if params[:dir] == "fav"
  #       redirect_to "/favorites"
  #     else
  #       redirect_to "/pets/#{pet.id}"
  #     end
  #   end
  # end

end
