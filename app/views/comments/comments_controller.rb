class CommentsController < ApplicationController
  def create
    @gossip = Gossip.find(params[:gossip_id])
    # Rappel : on utilise commentable car ta table est polymorphique
    @comment = Comment.new(
      content: params[:content], 
      commentable: @gossip, 
      user: User.find_by(first_name: "Anonymous")
    )

    if @comment.save
      flash[:success] = "Commentaire ajouté !"
      redirect_to gossip_path(@gossip)
    else
      flash[:danger] = "Erreur : le commentaire ne peut pas être vide."
      redirect_to gossip_path(@gossip)
    end
  end

  def edit
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.find(params[:id])
    
    if @comment.update(content: params[:content])
      flash[:success] = "Commentaire mis à jour !"
      redirect_to gossip_path(@gossip)
    else
      render :edit
    end
  end

  def destroy
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = "Commentaire supprimé !"
    # On utilise status: :see_other pour aider Turbo à bien rediriger après un DELETE
    redirect_to gossip_path(@gossip), status: :see_other
  end
end