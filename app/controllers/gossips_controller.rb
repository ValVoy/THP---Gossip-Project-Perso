class GossipsController < ApplicationController
  # 1. LES FILTRES (S'exécutent avant les méthodes)
  # On interdit l'accès aux non-connectés pour créer, voir ou modifier
  before_action :authenticate_user, only: [:new, :create, :show, :edit, :update, :destroy]
  
  # On vérifie que seul l'auteur peut modifier ou supprimer son potin
  before_action :require_owner, only: [:edit, :update, :destroy]

  def index
    @gossips = Gossip.all.order(created_at: :desc)
  end

  def show
    @gossip = Gossip.find(params[:id])
    @comment = Comment.new 
  end

  def new
    @gossip = Gossip.new
    @all_tags = Tag.all
  end

  def create
    @gossip = Gossip.new(gossip_params)
    @gossip.user = current_user 

    if @gossip.save
      # Bonus : On lie le tag sélectionné
      JoinTableGossipTag.create(gossip: @gossip, tag: Tag.find(params[:tag])) if params[:tag]
      
      flash[:success] = "Potin créé avec succès !"
      redirect_to root_path
    else
      @all_tags = Tag.all 
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @all_tags = Tag.all
  end

  def update
    if @gossip.update(title: params[:title], content: params[:content])
      @gossip.join_table_gossip_tags.destroy_all 
      JoinTableGossipTag.create(gossip: @gossip, tag: Tag.find(params[:tag]))
      flash[:success] = "Potin mis à jour !"
      redirect_to gossip_path(@gossip.id)
    else
      @all_tags = Tag.all
      render :edit
    end
  end

  def destroy
    @gossip.destroy
    flash[:success] = "Potin supprimé avec succès !"
    redirect_to root_path
  end

  # 2. LES MÉTHODES PRIVÉES (Accessibles uniquement depuis ce contrôleur)
  private

  def gossip_params
    params.require(:gossip).permit(:title, :content)
  end

  # Vérifie si l'utilisateur est connecté
  def authenticate_user
    unless logged_in?
      flash[:danger] = "Veuillez vous connecter pour accéder à cette page."
      redirect_to new_session_path
    end
  end

  # Vérifie si l'utilisateur connecté est bien le propriétaire du potin
  def require_owner
    @gossip = Gossip.find(params[:id])
    unless current_user == @gossip.user
      flash[:danger] = "Tu ne peux pas modifier un potin qui ne t'appartient pas !"
      redirect_to root_path
    end
  end
end