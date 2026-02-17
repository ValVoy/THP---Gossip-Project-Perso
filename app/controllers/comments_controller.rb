class CommentsController < ApplicationController
  def create
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.new(
      content: params[:content], 
      gossip: @gossip, 
      user: User.find_by(first_name: "Anonymous")
    )

    if @comment.save
      flash[:success] = "Commentaire ajouté !"
      redirect_to gossip_path(@gossip)
    else
      flash[:danger] = "Le commentaire ne peut pas être vide."
      redirect_to gossip_path(@gossip)
    end
  end
end