class CodesController < ApplicationController
  def clear
    Code.destroy_all
    redirect_to :back
  end
  
  def index
    @code = Code.new
    @codes = Code.all.reverse
  end
  
  def edit
    @code = Code.find(params[:id])
  end
  
  def update
    @code = Code.find(params[:id])
    @code.update(params[:code].permit(:code, :is_a_board, :title, :image,
      :advertiser, :board_number, :board_loc))
    redirect_to codes_path
  end
  
  def create
    @code = Code.new(params[:code].permit(:code, :is_a_board, :title, :image,
      :advertiser, :board_number, :board_loc))
    
    if @code.save
      flash[:notice] = "Code saved."
      redirect_to :back
    else
      if @code.code.nil?
        flash[:error] = "A code must be entered."
        
      elsif @code.errors.include? :board_code_exists
        flash[:error] = @code.errors[:board_code_exists].first
        
      elsif @code.errors.include? :card_code_exists
        flash[:error] = @code.errors[:card_code_exists].first
        
      elsif @code.errors.include? :board_needs_number
        flash[:error] = @code.errors[:board_needs_number].first
        
      else
        flash[:error] = "Invalid input"
      end
      redirect_to :back
    end
  end
  
  def destroy
    @code = Code.find(params[:id])
    @code.destroy
    redirect_to :back
  end
end
