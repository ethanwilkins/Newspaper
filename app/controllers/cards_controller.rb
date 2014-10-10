class CardsController < ApplicationController
  def show
    @card = Card.find(params[:id])
  end
  
  def create
    @game_board = GameBoard.find(params[:game_board_id])
    @code = Card.redeem params[:code], @game_board.board_number
    @card = @game_board.cards.find_by_board_loc(@code.board_loc) if @code
    
    if @card
      @card.update redeemed: true, code_id: @code.id, image: @card.redeemed_img
      if @game_board.you_won!
        flash[:notice] = translate "You won!"
      end
      redirect_to :back
    else
      flash[:error] = translate "Invalid code."
      redirect_to :back
    end
  end
end
