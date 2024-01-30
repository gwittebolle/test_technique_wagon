class Match < ApplicationRecord
  belongs_to :game
  has_many :solutions, dependent: :destroy

  # validates :word, presence: true

  def self.top_words(ten_letters_list)
    word_list_path = Rails.root.join('app', 'assets', 'words.txt')
    valid_word_list = File.read(word_list_path).split("\n").map(&:downcase)
    valid_word_list.select { |word| in_grid?(word, ten_letters_list.upcase.chars) }.sort_by(&:length).reverse.first(10)
  end

  def self.in_grid?(attempt, grid)
    attempt = attempt.upcase.chars
    attempt.all? { |char| grid.include?(char) } && attempt.all? { |char| grid.count(char) >= attempt.count(char) }
  end

end
