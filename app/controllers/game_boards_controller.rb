class GameBoardsController < ApplicationController
  def create
    @code = GameBoard.redeem params[:code]
    @game_board = current_user.game_boards.new(code_id: @code.id) if @code
    
    if @code and @game_board.save
      redirect_to user_game_board_path(current_user, @game_board)
    else
      redirect_to :back
    end
  end
  
  def show
    @game_board = GameBoard.find(params[:id])
    @card = Card.new
  end
end
