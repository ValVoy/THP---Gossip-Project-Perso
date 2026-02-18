class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.city = City.all.sample # Attribution d'une ville au hasard pour le test

    if @user.save
      log_in(@user)
      flash[:success] = "Bienvenue, #{@user.first_name} !"
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    # On récupère tous les potins de cet utilisateur pour les afficher sur son profil
    @user_gossips = @user.gossips.order(created_at: :desc)
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :age, :description, :password, :password_confirmation)
  end
end