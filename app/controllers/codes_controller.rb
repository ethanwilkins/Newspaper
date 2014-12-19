class CodesController < ApplicationController
  def clear
    zip_code = params[:zip_code]
    clear_all = params[:clear_all]
    any_codes = Code.all.present?
    if zip_code.present? and any_codes
      Code.where(zip_code: zip_code).destroy_all
      flash[:notice] = "Codes in #{zip_code} deleted successfully."
    elsif clear_all and any_codes
      Code.destroy_all
      flash[:notice] = translate("All codes deleted successfully.")
    elsif not any_codes
      flash[:error] = translate("There aren't any codes to delete.")
    else
      flash[:error] = translate("Invalid input.")
      no_input = true
    end
    GameBoard.repopulate(zip_code) unless no_input
    log_action("codes_clear")
    redirect_to :back
  end
  
  def index
    @code = Code.new
    @codes = Code.all.reverse
    log_action("codes_index")
  end
  
  def edit
    @code = Code.find(params[:id])
    log_action("codes_edit", @code.id)
  end
  
  def update
    @code = Code.find(params[:id])
    @code.update(params[:code].permit(:code, :is_a_board, :title, :image,
      :advertiser, :board_number, :board_loc))
    log_action("codes_update", @code.id)
    redirect_to codes_path
  end
  
  def create
    @code = Code.new(params[:code].permit(:code, :is_a_board, :card_name, :image,
      :advertiser, :board_number, :board_loc, :group_id))
    if @code.save
      flash[:notice] = translate "Code saved successfully."
      log_action("codes_create", @code.id)
      redirect_to :back
    else
      if @code.code.nil?
        flash[:error] = translate "A code must be entered." 
      elsif @code.errors.include? :board_needs_number
        flash[:error] = translate(@code.errors[:board_needs_number].first)
      elsif @code.errors.include? :board_number_only_for_boards
        flash[:error] = translate(@code.errors[:board_number_only_for_boards].first)
      elsif @code.errors.include? :invalid_format
        flash[:error] = translate(@code.errors[:invalid_format].first)
      elsif @code.errors.include? :group_id_not_required
        flash[:error] = translate(@code.errors[:group_id_not_required].first)
      elsif @code.errors.include? :group_id_required
        flash[:error] = translate(@code.errors[:group_id_required].first)
      else
        flash[:error] = translate "Invalid input"
      end
      log_action("codes_create_fail")
      redirect_to :back
    end
  end
  
  def destroy
    @code = Code.find(params[:id])
    @code.destroy
    log_action("codes_destroy")
    redirect_to :back
  end
end
