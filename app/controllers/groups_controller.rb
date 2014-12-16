class GroupsController < ApplicationController
  def add_member
    if params[:user_name].present? and User.find_by_name(params[:user_name]) and \
      (User.find_by_name(params[:user_name]).group_id.nil? or User.find_by_name(params[:user_name]).group_id == 0)
      User.find_by_name(params[:user_name]).update group_id: params[:group_id], admin: true
      flash[:notice] = translate("Admin successfully added to group.")
      Activity.log_action(current_user, request.remote_ip.to_s, "groups_add_member", params[:group_id])
    else
      flash[:error] = translate("User does not exist or already belongs to a group.")
      Activity.log_action(current_user, request.remote_ip.to_s, "groups_add_member_fail", params[:group_id])
    end
    redirect_to :back
  end
  
  def remove_member
    admin = User.find_by_id(params[:user_id])
    if admin and admin.group_id.present? and admin.update group_id: 0
      flash[:notice] = translate("Member successfully removed from the group.")
      Activity.log_action(current_user, request.remote_ip.to_s, "groups_remove_member", admin.id)
    else
      flash[:error] = translate("The member could not be removed.")
      Activity.log_action(current_user, request.remote_ip.to_s, "groups_remove_member_fail", admin.id)
    end
    redirect_to :back
  end
  
  def add_zip
    if params[:zip_code].present? and Zip.find_by_zip_code(params[:zip_code]) and \
      (Zip.find_by_zip_code(params[:zip_code]).group_id.nil? or Zip.find_by_zip_code(params[:zip_code]).group_id == 0)
      Zip.find_by_zip_code(params[:zip_code]).update group_id: params[:group_id]
      flash[:notice] = translate("Zip code successfully added to group.")
      Activity.log_action(current_user, request.remote_ip.to_s, "groups_add_zip", params[:group_id])
    else
      flash[:error] = translate("Zip code does not exist in database or already belongs to a group.")
      Activity.log_action(current_user, request.remote_ip.to_s, "groups_add_zip_fail", params[:group_id])
    end
    redirect_to :back
  end
  
  def remove_zip
    zip = Zip.find_by_zip_code(params[:zip_code])
    if zip and zip.group_id.present? and zip.update group_id: 0
      flash[:notice] = translate("Zip code successfully removed from the group.")
      Activity.log_action(current_user, request.remote_ip.to_s, "groups_remove_zip", zip.id)
    else
      flash[:error] = translate("The zip code could not be removed.")
      Activity.log_action(current_user, request.remote_ip.to_s, "groups_remove_zip_fail", zip.id)
    end
    redirect_to :back
  end
  
  def edit
    @group = Group.find(params[:id])
    Activity.log_action(current_user, request.remote_ip.to_s, "groups_edit")
  end
  
  def index
    @groups = Group.all
    session[:group_id] = nil
    Activity.log_action(current_user, request.remote_ip.to_s, "groups_index")
  end
  
  def new
    @group = Group.new
    Activity.log_action(current_user, request.remote_ip.to_s, "groups_new")
  end
  
  def show
    @group = Group.find(params[:id])
    session[:group_id] = @group.id
    Activity.log_action(current_user, request.remote_ip.to_s, "groups_show")
  end
  
  def create
    @group = Group.new(params[:group].permit(:max_prizes))
    if @group.save
      @group.assemble(params[:zip_list], params[:admin_list])
      flash[:notice] = translate("Group saved successfully.")
      Activity.log_action(current_user, request.remote_ip.to_s, "groups_create", @group.id)
      redirect_to groups_path
    else
      flash[:error] = translate("Group failed to save.")
      Activity.log_action(current_user, request.remote_ip.to_s, "groups_create_fail")
      redirect_to :back
    end
  end
  
  def update
    @group = Group.find(params[:id])
    if @group.add_prizes(params[:prize_combo_type], params[:prize_amount])
      Activity.log_action(current_user, request.remote_ip.to_s, "groups_update", @group.id)
      flash[:notice] = translate("Group updated successfully.")
      redirect_to :back
    else
      flash[:error] = translate("Group failed to update.")
      Activity.log_action(current_user, request.remote_ip.to_s, "groups_update_fail")
      redirect_to :back
    end
  end
end
