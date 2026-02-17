class CommentsController < ApplicationController
  def create
    @gossip = Gossip.find(params[:gossip_id])
    
    # On utilise l'association polymorphique ici
    @comment = Comment.new(
      content: params[:content], 
      commentable: @gossip, # On remplace 'gossip' par 'commentable'
      user: User.find_by(first_name: "Anonymous")
    )

    if @comment.save
      flash[:success] = "Commentaire ajouté !"
      redirect_to gossip_path(@gossip)
    else
      flash[:danger] = "Erreur lors de l'ajout du commentaire."
      redirect_to gossip_path(@gossip)
    end
  end
end