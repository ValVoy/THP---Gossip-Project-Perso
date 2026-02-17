class CommentsController < ApplicationController
  def create
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.new(content: params[:content], gossip: @gossip, user: User.find_by(first_name: "Anonymous"))

    if @comment.save
      flash[:success] = "Commentaire ajouté !"
      redirect_to gossip_path(@gossip)
    else
      # Si erreur, on recharge la page du potin avec un message
      flash[:danger] = "Erreur : le commentaire ne peut pas être vide."
      redirect_to gossip_path(@gossip)
    end
  end

  # Les méthodes edit, update et destroy seront pour plus tard dans ton avancée
end