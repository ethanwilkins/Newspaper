class GameBoardsController < ApplicationController
  def reset
    @game_board = GameBoard.find(params[:id])
    @game_board.cards.destroy_all
    @game_board.populate
  end
  
  def create
    @code = GameBoard.redeem params[:code]
    @game_board = current_user.game_boards.new(code_id: @code.id) if @code
    
    if @code and @game_board.save
      @game_board.populate
      redirect_to user_game_board_path(current_user, @game_board)
    else
      redirect_to :back
    end
  end
  
  def destroy
    @game_board = GameBoard.find(params[:id])
    @game_board.destroy
    redirect_to root_url
  end
  
  def show
    @cards = GameBoard.find(params[:id]).cards
    @card = Card.new
  end
end
