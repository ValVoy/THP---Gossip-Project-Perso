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
    anonymous_user = User.find_by(first_name: "Anonymous")
    @gossip = Gossip.new(
      title: params[:title],
      content: params[:content],
      user: anonymous_user
    )

    if @gossip.save
      flash[:success] = "Super ! Le potin a été créé avec succès."
      redirect_to root_path
    else
      # On ne met pas de flash[:danger] ici car les erreurs sont affichées 
      # via @gossip.errors dans la vue 'new' grâce au render
      render :new
    end
  end
end