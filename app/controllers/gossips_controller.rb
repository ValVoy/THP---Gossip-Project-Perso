class GossipsController < ApplicationController
  def index
    @gossips = Gossip.all.order(created_at: :desc)
  end

  def show
    @gossip = Gossip.find(params[:id])
    @comment = Comment.new 
  end

  def new
    @gossip = Gossip.new
    # ÉTAPE 2 : On charge tous les tags pour les envoyer à la vue
    @all_tags = Tag.all
  end

  def create
    @gossip = Gossip.new(
      title: params[:title],
      content: params[:content],
      user: User.find_by(first_name: "Anonymous")
    )

    if @gossip.save
      JoinTableGossipTag.create(gossip: @gossip, tag: Tag.find(params[:tag]))

      flash[:success] = "Potin créé !"
      redirect_to root_path
    else
      @all_tags = Tag.all
      render :new
    end
  end

  def edit
    @gossip = Gossip.find(params[:id])
    @all_tags = Tag.all
  end

  def update
    @gossip = Gossip.find(params[:id])
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
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    flash[:success] = "Potin supprimé avec succès !"
    redirect_to root_path
  end
end