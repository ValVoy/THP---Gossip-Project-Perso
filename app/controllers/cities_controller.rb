class CitiesController < ApplicationController
  def show
    @city = City.find(params[:id])
    # On récupère tous les potins liés aux utilisateurs de cette ville
    @gossips = Gossip.joins(:user).where(users: { city_id: @city.id })
  end
end