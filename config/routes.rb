Rails.application.routes.draw do
  get "likes/create"
  get "likes/destroy"
  # Page d'accueil
  root "static_pages#home"

  # Sessions (Connexion/Déconnexion)
  # Cela crée automatiquement new_session_path, sessions_path, etc.
  resources :sessions, only: [ :new, :create, :destroy ]

  # Utilisateurs
  # On ajoute :new et :create pour permettre l'inscription
  resources :users, only: [ :show, :new, :create ]

  resources :cities, only: [ :index, :show ]

  # Potins et Commentaires
  resources :gossips do
    resources :comments, only: [ :create, :edit, :update, :destroy ]
    resources :likes, only: [ :create, :destroy ]
  end

  # Villes
  resources :cities, only: [ :show ]

  # Pages statiques
  get "/team", to: "static_pages#team"
  get "/contact", to: "static_pages#contact"
  get "/welcome/:first_name", to: "static_pages#welcome", as: "welcome"
end
