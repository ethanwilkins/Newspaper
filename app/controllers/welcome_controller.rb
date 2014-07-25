class WelcomeController < ApplicationController
  def index
    @banner = Banner.last
    @user = User.new
    if current_user
      @game_board = GameBoard.new
      @game_boards = current_user.game_boards.reverse
    end
  end
end
