class WelcomeController < ApplicationController
  def index
    @user = User.new
    if current_user
      @card = Card.new
      @cards = current_user.cards
    end
  end
end
