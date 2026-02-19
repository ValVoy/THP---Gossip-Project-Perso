class User < ApplicationRecord
  belongs_to :city
  has_many :gossips, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :sent_messages, foreign_key: :sender_id, class_name: "PrivateMessage"
  has_many :private_message_recipients, foreign_key: :recipient_id
  has_many :received_messages, through: :private_message_recipients, source: :private_message

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # --- MÉTHODE MANQUANTE À AJOUTER ---
  def remember(remember_token)
    remember_digest = BCrypt::Password.create(remember_token)
    # On utilise update_column pour bypasser les validations de mot de passe lors du login
    self.update_column(:remember_digest, remember_digest)
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    self.update_column(:remember_digest, nil)
  end
end
