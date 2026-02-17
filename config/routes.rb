Rails.application.routes.draw do
  # On change la racine : elle pointe maintenant vers static_pages#home
  root "static_pages#home"

  # Tes pages statiques actuelles
  get "/team", to: "static_pages#team"
  get "/contact", to: "static_pages#contact"
  get "/welcome/:first_name", to: "static_pages#welcome", as: "welcome"

  # On garde toutes les ressources RESTful (ton index complet sera ici)
  resources :gossips do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  resources :users, only: [:show]
  resources :cities, only: [:show]
end