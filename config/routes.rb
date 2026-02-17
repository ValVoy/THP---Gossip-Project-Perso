Rails.application.routes.draw do
  # Page d'accueil
  root "gossips#index"

  # Pages statiques
  get "/team", to: "static_pages#team"
  get "/contact", to: "static_pages#contact"
  get "/welcome/:first_name", to: "static_pages#welcome", as: "welcome"

  # Ressources RESTful
  # On ouvre toutes les routes pour Gossips (index, show, new, create, edit, update, destroy)
  resources :gossips do
    # Les commentaires sont imbriqués : ils dépendent d'un gossip_id
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  # Routes pour les Utilisateurs et les Villes
  resources :users, only: [:show]
  resources :cities, only: [:show]
end