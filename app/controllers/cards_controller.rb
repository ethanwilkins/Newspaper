class CardsController < ApplicationController
  def show
    @card = Card.find(params[:id])
  end
  
  def create
    @user = User.find(current_user)
    @card = @user.cards.new(params[:card].permit(:code))
    
    if @card.save and @card.redeem
      redirect_to user_card_path(current_user, @card)
    else
      redirect_to user_cards_path(current_user)
    end
  end
end
