require "faker"

puts "Nettoyage de la base de données..."
Like.destroy_all
Comment.destroy_all
PrivateMessageRecipient.destroy_all
PrivateMessage.destroy_all
JoinTableGossipTag.destroy_all
Gossip.destroy_all
Tag.destroy_all
User.destroy_all
City.destroy_all

puts "Base de données propre. Début du seed..."

# --- VILLES ---
10.times do
  City.create!(
    name: Faker::Address.city,
    zip_code: Faker::Address.zip_code
  )
end
puts "✅ 10 villes créées."

# --- UTILISATEURS ---
10.times do |i|
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Lorem.paragraph(sentence_count: 2),
    email: "user#{i}@yopmail.com",
    age: rand(18..70),
    city: City.all.sample,
    password: "password123",
    password_confirmation: "password123"
  )
end
puts "✅ 10 utilisateurs créés."

# --- GOSSIPS ---
20.times do
  Gossip.create!(
    title: Faker::Lorem.characters(number: rand(5..12)),
    content: Faker::Lorem.paragraph(sentence_count: 4),
    user: User.all.sample
  )
end
puts "✅ 20 gossips créés."

# --- TAGS ---
["#Hot", "#Work", "#Love", "#Secret", "#Humour", "#Life", "#Drama"].each do |title|
  Tag.create!(title: title)
end
puts "✅ Tags créés."

# --- LIEN GOSSIP / TAG ---
Gossip.all.each do |gossip|
  tags = Tag.all.sample(rand(1..2))
  tags.each do |tag|
    JoinTableGossipTag.create!(gossip: gossip, tag: tag)
  end
end
puts "✅ Tags assignés."

# --- MESSAGES PRIVÉS ---
15.times do
  pm = PrivateMessage.create!(
    content: Faker::Lorem.paragraph(sentence_count: 2),
    sender: User.all.sample
  )
  recipients = User.where.not(id: pm.sender_id).sample(rand(1..3))
  recipients.each do |recipient|
    PrivateMessageRecipient.create!(private_message: pm, recipient: recipient)
  end
end
puts "✅ 15 messages privés."

# --- COMMENTAIRES ---
# Étape A : Créer des commentaires uniquement sur des Gossips (pour être sûr qu'ils existent)
15.times do
  Comment.create!(
    content: Faker::Lorem.sentence(word_count: 10),
    user: User.all.sample,
    commentable: Gossip.all.sample
  )
end

# Étape B : Créer des réponses à des commentaires (Maintenant que le pool de commentaires n'est plus vide)
5.times do
  Comment.create!(
    content: Faker::Lorem.sentence(word_count: 8),
    user: User.all.sample,
    commentable: Comment.all.sample
  )
end
puts "✅ 20 commentaires créés (Gossips + Réponses)."

# --- LIKES ---
40.times do
  user = User.all.sample
  # On like soit un Gossip, soit un Commentaire
  target = [Gossip.all.sample, Comment.all.sample].sample
  unless Like.exists?(user: user, likeable: target)
    Like.create!(user: user, likeable: target)
  end
end
puts "✅ Likes distribués."

puts "--- SEED TERMINÉ AVEC SUCCÈS ---"