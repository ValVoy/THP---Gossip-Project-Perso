class Gossip < ApplicationRecord
  belongs_to :user
  has_many :join_table_gossip_tags
  has_many :tags, through: :join_table_gossip_tags
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  # --- AJOUT DES VALIDATIONS (Consigne 2.1) ---
  # Le titre est obligatoire et doit faire entre 3 et 14 caractères
  validates :title,
    presence: true,
    length: { minimum: 3, maximum: 14, message: "doit faire entre 3 et 14 caractères" }

  # Le contenu est obligatoire
  validates :content,
    presence: true
end
