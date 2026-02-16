Rails.application.routes.draw do
  get "users/show"
  get "gossips/index"
  get "gossips/show"
  # Page d'accueil (Consigne 2.5)
  root "gossips#index"

  # Pages statiques (Consigne 2.2)
  get "/team", to: "static_pages#team"
  get "/contact", to: "static_pages#contact"

  # Landing page dynamique (Consigne 2.4)
  get "/welcome/:first_name", to: "static_pages#welcome", as: "welcome"

  # Pages potins et utilisateurs (Consigne 2.6 & 2.7)
  resources :gossips, only: [ :show ]
  resources :users, only: [ :show ]
end
