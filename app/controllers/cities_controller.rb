class CitiesController < ApplicationController
  def index
    # On récupère toutes les villes et on les trie par nom
    @cities = City.all.order(:name)
  end

  def show
    @city = City.find(params[:id])
    # On récupère tous les potins postés par des utilisateurs de cette ville
    # On passe par les utilisateurs (users) pour arriver aux potins (gossips)
    @city_gossips = Gossip.joins(:user).where(users: { city_id: @city.id }).order(created_at: :desc)
  end
end
