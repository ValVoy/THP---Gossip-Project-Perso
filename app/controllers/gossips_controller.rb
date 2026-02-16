class GossipsController < ApplicationController
  def index
    @gossips = Gossip.all
  end

  def show
    @gossip = Gossip.find(params[:id])
  end

  def new
    # On crée une instance vide pour le formulaire
    @gossip = Gossip.new
  end

  def create
    # On récupère les données du formulaire via params
    # On associe le potin à notre utilisateur anonyme (Consigne 2.2.3.1)
    @gossip = Gossip.new(
      title: params[:title],
      content: params[:content],
      user: User.find_by(first_name: "Anonymous")
    )

    if @gossip.save
      # Succès : redirection vers l'index
      redirect_to root_path
    else
      # Échec : on réaffiche le formulaire avec les erreurs
      render :new
    end
  end
end