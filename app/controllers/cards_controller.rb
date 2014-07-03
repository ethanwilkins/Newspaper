class CardsController < ApplicationController
  def show
    @card = Card.find(params[:id])
  end
  
  def create
    @code = Card.redeem params[:code]
    @game_board = GameBoard.find(params[:game_board_id])
    @card = @game_board.cards.new(code_id: @code.id) if @code
    
    if @code and @card.save
      redirect_to :back
    else
      redirect_to :back
    end
  end
end
