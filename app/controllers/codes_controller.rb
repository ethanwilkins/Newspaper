class CodesController < ApplicationController
  def clear
    zip_code = params[:zip_code]
    clear_all = params[:clear_all]
    if zip_code.present?
      Code.where(zip_code: zip_code).destroy_all
      flash[:notice] = "Codes in #{zip_code} deleted successfully."
    elsif clear_all
      Code.destroy_all
      flash[:notice] = translate("All codes deleted successfully.")
    else
      flash[:error] = translate("Invalid input.")
      no_input = true
    end
    GameBoard.repopulate(zip_code) unless no_input
    Activity.log_action(current_user, request.remote_ip.to_s, "codes_clear")
    redirect_to :back
  end
  
  def index
    @code = Code.new
    @codes = Code.all.reverse
    Activity.log_action(current_user, request.remote_ip.to_s, "codes_index")
  end
  
  def edit
    @code = Code.find(params[:id])
    Activity.log_action(current_user, request.remote_ip.to_s, "codes_edit", @code.id)
  end
  
  def update
    @code = Code.find(params[:id])
    @code.update(params[:code].permit(:code, :is_a_board, :title, :image,
      :advertiser, :board_number, :board_loc))
    Activity.log_action(current_user, request.remote_ip.to_s, "codes_update", @code.id)
    redirect_to codes_path
  end
  
  def create
    @code = Code.new(params[:code].permit(:code, :is_a_board, :title, :image,
      :advertiser, :board_number, :board_loc, :zip_code))
    
    if @code.save
      flash[:notice] = translate "Code saved successfully."
      Activity.log_action(current_user, request.remote_ip.to_s, "codes_create", @code.id)
      redirect_to :back
    else
      if @code.code.nil?
        flash[:error] = translate "A code must be entered."
        
      elsif @code.errors.include? :board_code_exists
        flash[:error] = @code.errors[:board_code_exists].first
        
      elsif @code.errors.include? :card_code_exists
        flash[:error] = @code.errors[:card_code_exists].first
        
      elsif @code.errors.include? :board_needs_number
        flash[:error] = @code.errors[:board_needs_number].first
        
      else
        flash[:error] = translate "Invalid input"
      end
      Activity.log_action(current_user, request.remote_ip.to_s, "codes_create_fail")
      redirect_to :back
    end
  end
  
  def destroy
    @code = Code.find(params[:id])
    @code.destroy
    Activity.log_action(current_user, request.remote_ip.to_s, "codes_destroy")
    redirect_to :back
  end
end
