class CodesController < ApplicationController
  def create
    @code = Code.new(params[:code].permit(:code, :is_a_board, :title, :image))
    
    if @code.save
      redirect_to :back
    else
      render 'index'
    end
  end
end
