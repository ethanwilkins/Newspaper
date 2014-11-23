class CardsController < ApplicationController
  def show
    @card = Card.find(params[:id])
    Activity.log_action(current_user, request.remote_ip.to_s, "cards_show", @card.id)
  end
  
  def create
    @game_board = GameBoard.find(params[:game_board_id])
    @code = Card.redeem params[:code], @game_board.board_number
    @card = @game_board.cards.find_by_board_loc(@code.board_loc) if @code
    
    if @card
      @card.update redeemed: true, code_id: @code.id,
        image: @card.redeemed_img, zip_code: current_user.zip_code
      if @game_board.you_won!
        flash[:notice] = translate "You won!"
      end
      Activity.log_action(current_user, request.remote_ip.to_s, "cards_create", @card.id)
      redirect_to :back
    else
      flash[:error] = translate "Invalid code."
      Activity.log_action(current_user, request.remote_ip.to_s, "cards_create_fail")
      redirect_to :back
    end
  end
end
