# db/seeds.rb
User.destroy_all
Game.destroy_all
Match.destroy_all

VOYELLES = %w[a e i o u y]
CONSONNES = %w[b c d f g h j k l m n p q r s t v w x z]


user = User.create!(email: 'gaetan.wittebolle@gmail.com', password: 'azerty', best_score: 0)
game = user.games.new(actual_score: 0)

5.times do
  tirage = VOYELLES.sample(5) + CONSONNES.sample(5)
  tirage.shuffle!

  game.matches.new(
    ten_letters_list: tirage.join, # Convertit le tirage en chaîne de caractères
    word: tirage.sample(5).join, # Un exemple de mot constitué de lettres aléatoires du tirage
    available: true
  )
end

game.save!

puts 'Les données de seed ont été créées.'
