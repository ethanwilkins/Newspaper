class CodesController < ApplicationController
  def create
    @code = Code.new(params[:code].permit(:code, :is_a_board, :title, :image,
      :advertiser, :board_number, :board_loc))
    
    if @code.save
      redirect_to :back
    else
      if @code.is_a_board and @code.board_number.nil?
        flash[:error] = "Boards require a number."
      elsif @code.code.nil?
        flash[:error] = "A code must be entered."
      else
        flash[:error] = "Invalid input."
      end
      redirect_to :back
    end
  end
end
