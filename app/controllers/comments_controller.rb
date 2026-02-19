class CommentsController < ApplicationController
  before_action :authenticate_user
  before_action :require_owner, only: [ :edit, :update, :destroy ]

  def create
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.new(content: params[:content], user: current_user, commentable: @gossip)

    if @comment.save
      flash[:success] = "Commentaire ajouté !"
      redirect_to gossip_path(@gossip.id)
    else
      flash[:danger] = "Erreur : le commentaire ne peut pas être vide."
      redirect_to gossip_path(@gossip.id)
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
      flash[:success] = "Commentaire modifié !"
      redirect_to gossip_path(@gossip.id)
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = "Commentaire supprimé !"
    redirect_to gossip_path(params[:gossip_id])
  end

  private

  def require_owner
    @comment = Comment.find(params[:id])
    unless current_user == @comment.user
      flash[:danger] = "Tu ne peux pas modifier ce commentaire."
      redirect_to gossip_path(params[:gossip_id])
    end
  end
end
