class GameBoardsController < ApplicationController
  def reset
    @game_board = GameBoard.find(params[:id])
    @game_board.cards.destroy_all
    @game_board.populate
    Activity.log_action(current_user, request.remote_ip.to_s, "game_boards_reset", @game_board.id)
    redirect_to :back
  end
  
  def create
    @code = GameBoard.redeem params[:code], current_user
    @game_board = current_user.game_boards.new(code_id: @code.id, board_number: @code.board_number,
      zip_code: current_user.zip_code, group_id: @code.group_id) if @code
    
    if @game_board and @game_board.save
      @game_board.populate
      Activity.log_action(current_user, request.remote_ip.to_s, "game_boards_create", @game_board.id)
      redirect_to user_game_board_path(current_user, @game_board)
    else
      flash[:error] = translate("The code was not valid.")
      Activity.log_action(current_user, request.remote_ip.to_s, "game_boards_create_fail")
      redirect_to :back
    end
  end
  
  def destroy
    @game_board = GameBoard.find(params[:id])
    @game_board.destroy
    flash[:notice] = translate("The board was successfully deleted.")
    Activity.log_action(current_user, request.remote_ip.to_s, "game_boards_destroy")
    redirect_to user_game_boards_path(current_user)
  end
  
  def show
    @game_board = GameBoard.find(params[:id])
    @cards = @game_board.cards
    @card = Card.new
    Activity.log_action(current_user, request.remote_ip.to_s, "game_boards_show", @game_board.id)
  end
  
  def index
    @game_board = GameBoard.new
    @game_boards = current_user.game_boards.reverse
    @advert = Article.local_advert(current_user)
    Activity.log_action(current_user, request.remote_ip.to_s, "game_boards_index")
  end
end
