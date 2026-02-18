class ApplicationController < ActionController::Base
  include SessionsHelper

  # Cette méthode sera utilisée par tous les autres contrôleurs
  def authenticate_user
    unless logged_in?
      flash[:danger] = "Veuillez vous connecter pour accéder à cette page."
      redirect_to new_session_path
    end
  end
end