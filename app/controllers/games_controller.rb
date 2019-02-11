class GamesController < ApplicationController


  def new
    letter_array = ('A'..'Z').to_a.sample(10)
    @letters = letter_array

  end

  def score
    require 'json'
    require 'open-uri'

    query = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{query}"
    api = open(url).read
    word_api = JSON.parse(api)

    @result_api = "#{word_api['word']} #{word_api['found']}"


    # raise
    # binding.pry
    if word_api['found'] == true && params[:word].all?(params[:letters].split(" "))
      @score = "Congratulation! #{params[:word]} is a valid English word!"
    elsif word_api['found'] == false
      @score = "Sorry but #{params[:word]} can't built out of #{params[:letters]}"
    else
      @score = "Sorry but #{params[:word]} does not seem to be a valid English word..."
    end

  end
end
