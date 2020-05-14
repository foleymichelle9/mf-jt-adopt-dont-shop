class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :favorites

  def favorites
    @favorites ||= Favorites.new(session[:favorites])
  end
end
