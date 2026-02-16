Rails.application.routes.draw do
  # Page d'accueil
  root "gossips#index"

  # Pages statiques
  get "/team", to: "static_pages#team"
  get "/contact", to: "static_pages#contact"
  get "/welcome/:first_name", to: "static_pages#welcome", as: "welcome"

  # Ressources RESTful (Consigne 2.2.1)
  # On ajoute :index, :new et :create à la liste
  resources :gossips, only: [ :index, :show, :new, :create ]
  resources :users, only: [ :show ]
end
