class SessionsController < ApplicationController
  def new
    # Juste pour afficher la page de login
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      log_in(user) # On utilise notre helper
      flash[:success] = "Content de vous revoir !"
      redirect_to root_path
    else
      flash.now[:danger] = 'Email ou mot de passe invalide'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = "À bientôt !"
    redirect_to root_path
  end
end