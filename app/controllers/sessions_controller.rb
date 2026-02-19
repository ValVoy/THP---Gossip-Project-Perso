class SessionsController < ApplicationController
  def new
    # Affiche la page de login
  end

  def create
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      # 1. Connexion classique (session)
      log_in(user)
      
      # 2. Gestion du "Se souvenir de moi"
      # Si la checkbox est cochée (valeur '1'), on crée les cookies permanents
      # Sinon, on s'assure que les anciens cookies sont supprimés
      params[:remember_me] == '1' ? remember(user) : forget(user)
      
      flash[:success] = "Content de vous revoir, #{user.first_name} !"
      redirect_to root_path
    else
      flash.now[:danger] = "Email ou mot de passe invalide"
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    
    flash[:success] = "À bientôt !"
    redirect_to root_path, status: :see_other
  end
end