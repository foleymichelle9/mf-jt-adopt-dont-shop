class ApplicationsController < ApplicationController

  def new
    @pets = favorites.selection_form_ready
  end
end
