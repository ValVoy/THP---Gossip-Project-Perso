class StaticPagesController < ApplicationController
  def home
    # .limit(3) permet de ne récupérer que les 3 potins les plus récents
    @gossips = Gossip.order(created_at: :desc).limit(3)
  end

  def team; end
  def contact; end
  def welcome
    @first_name = params[:first_name]
  end
end