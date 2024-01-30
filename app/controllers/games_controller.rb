# app/controllers/games_controller.rb
class GamesController < ApplicationController
  # before_action :authenticate_user!

  def create

    game = current_user.games.new(actual_score: 0)

    game.save!

    redirect_to game_match_path(game, game.matches.first)

  end

  def next_match
    game = current_user.games.last
    @next_match = game.matches.find_by(word: '') # Trouve le premier match avec word vide

    if @next_match
      redirect_to game_match_path(game, @next_match)
    else
      redirect_to root_path # Redirige vers la page d'accueil si aucun match n'a word vide
    end
  end
end
