class MatchesController < ApplicationController
  def show
    @match = Match.find(params[:id])
  end

  def update
    @match = Match.find(params[:id])
    word = match_params.values.first
    grid = @match.ten_letters_list.upcase.chars
    # Vérifiez si le mot est dans la grille et peut être formé
    valid_word = in_grid?(word, grid)

    # Vérifiez si le mot est dans la liste de mots valide
    word_list_path = Rails.root.join('app', 'assets', 'words.txt')
    valid_word_list = File.read(word_list_path).split("\n").map(&:downcase)

    valid_word = valid_word && valid_word_list.include?(word.downcase)

    if valid_word
      @match.word = word
      @match.game.actual_score += word.length
      current_user.best_score = @match.game.actual_score if @match.game.actual_score > current_user.best_score

      if @match.save && @match.game.save && current_user.save
        redirect_to results_game_match_path(@match)
      else
        render :edit
      end
    else
      flash[:alert] = "Le mot n'est pas valide."
      render :show, status: :unprocessable_entity
    end
  end

  def results
    @match = Match.find(params[:id])
    @top_words = Match.top_words(@match.ten_letters_list)
  end

  private

  def match_params
    params.require(:match).permit(:word)
  end

  def in_grid?(attempt, grid)
    attempt = attempt.upcase.chars
    attempt.all? { |char| grid.include?(char) } && attempt.all? { |char| grid.count(char) >= attempt.count(char) }
  end

end
