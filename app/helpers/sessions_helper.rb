module SessionsHelper
  # Connecte l'utilisateur donné
  def log_in(user)
    session[:user_id] = user.id
  end

  # Récupère l'utilisateur actuel via la session OU le cookie
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Retourne vrai si l'utilisateur est connecté
  def logged_in?
    !current_user.nil?
  end

  # Créé les cookies pour se souvenir de l'utilisateur
  def remember(user)
    # Génère un token aléatoire
    remember_token = SecureRandom.urlsafe_base64
    # Sauvegarde le digest du token en base de données
    user.remember(remember_token)
    # Stocke l'ID chiffré dans un cookie permanent
    cookies.permanent.signed[:user_id] = user.id
    # Stocke le token en clair dans un cookie permanent
    cookies.permanent[:remember_token] = remember_token
  end

  # Annule la persistance du cookie
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Déconnecte l'utilisateur
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end
