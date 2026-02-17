class GossipsController < ApplicationController
  def index
    @gossips = Gossip.all
  end

  def show
    @gossip = Gossip.find(params[:id])
    # On prépare un objet vide pour le formulaire de commentaire dans la vue show
    @comment = Comment.new 
  end

  def new
    @gossip = Gossip.new
  end

  def create
    @gossip = Gossip.new(
      title: params[:title],
      content: params[:content],
      user: User.find_by(first_name: "Anonymous")
    )

    if @gossip.save
      flash[:success] = "Potin créé !"
      redirect_to root_path
    else
      render :new
    end
  end

  # --- NOUVELLES MÉTHODES DU JOUR ---

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])
    # On met à jour avec les données du formulaire edit
    if @gossip.update(title: params[:title], content: params[:content])
      flash[:success] = "Potin mis à jour !"
      redirect_to gossip_path(@gossip.id)
    else
      render :edit
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    flash[:success] = "Potin supprimé avec succès !"
    redirect_to root_path
  end
end