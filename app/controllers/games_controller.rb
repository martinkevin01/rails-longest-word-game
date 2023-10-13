require 'open-uri'
class GamesController < ApplicationController

  def new
    random_letters = ('A'..'Z').to_a.shuffle
    @letters = random_letters[0, 10]
  end

  def score
    @suggestion = params[:suggestion]
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{@suggestion}")
    @json = JSON.parse(response.read)
    # @json['found']
    if @suggestion.include?(@letters.to_s) && @json['found']
      @result = "Le mot est valide d'après la grille et est un mot anglais valide."
    elsif !@suggestion.include?(@letters.to_s)
      @result = "Sorry but #{@suggestion} can't be built out of #{@letters}"
    else
      @result = "Le mot est valide d'après la grille, mais ce n'est pas un mot anglais valide."
    end
  end
end
