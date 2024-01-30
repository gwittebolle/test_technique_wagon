class Game < ApplicationRecord
  belongs_to :user

  has_many :matches, dependent: :destroy
  # validate :has_exactly_five_matches

  after_create :generate_matches

  private

  def has_exactly_five_matches
    errors.add(:matches, "doit avoir exactement 5 parties") unless matches.size == 5
  end

  def generate_matches
    voyelles = %w[a e i o u y]
    consonnes = %w[b c d f g h j k l m n p q r s t v w x z]

    5.times do
      tirage = (voyelles.sample(5) + consonnes.sample(5)).shuffle.join
      matches.create!(
        ten_letters_list: tirage,
        word: '', # Ce champ devrait être mis à jour avec un mot valide selon vos règles
        available: true
      )
    end
  end
end
