class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # 1. On crée l'utilisateur avec les paramètres sécurisés
    # Note : On récupère une ville au hasard pour le moment pour éviter les bugs de FK
    @user = User.new(user_params)
    @user.city = City.all.sample 

    if @user.save
      # 2. On connecte l'utilisateur immédiatement (méthode de notre helper)
      log_in(@user)
      
      # 3. Message de succès et redirection
      flash[:success] = "Bienvenue dans la communauté, #{@user.first_name} !"
      redirect_to root_path
    else
      # 4. En cas d'erreur (ex: mot de passe trop court), on réaffiche le formulaire
      flash.now[:danger] = "Erreur lors de l'inscription : " + @user.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    # On autorise explicitement le password et sa confirmation
    params.require(:user).permit(:first_name, :last_name, :email, :age, :description, :password, :password_confirmation)
  end
end