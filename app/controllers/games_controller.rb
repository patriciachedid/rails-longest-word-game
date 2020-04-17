require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = Array.new(9) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split("")
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
    if @included
      if @english_word
        @results = 'well done'
      else
        @results = 'not an english word'
      end
    else
      @results = 'you guess dont match the given word'
    end
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end

