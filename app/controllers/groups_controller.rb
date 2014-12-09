class GroupsController < ApplicationController
  def add_member
    if params[:user_name].present? and User.find_by_name(params[:user_name]) and \
      (User.find_by_name(params[:user_name]).group_id.nil? or User.find_by_name(params[:user_name]).group_id == 0)
      User.find_by_name(params[:user_name]).update group_id: params[:group_id], admin: true
      flash[:notice] = translate("Admin successfully added to group.")
    else
      flash[:error] = translate("User does not exist or already belongs to a group.")
    end
    redirect_to :back
  end
  
  def add_zip
    if params[:zip_code].present? and Zip.find_by_zip_code(params[:zip_code]) and \
      (Zip.find_by_zip_code(params[:zip_code]).group_id.nil? or Zip.find_by_zip_code(params[:zip_code]).group_id == 0)
      Zip.find_by_zip_code(params[:zip_code]).update group_id: params[:group_id]
      flash[:notice] = translate("Zip code successfully added to group.")
    else
      flash[:error] = translate("Zip code does not exist in database or already belongs to a group.")
    end
    redirect_to :back
  end
  
  def remove_zip
    zip = Zip.find_by_zip_code(params[:zip_code])
    if zip and zip.group_id.present? and zip.update group_id: 0
      flash[:notice] = translate("Zip code successfully removed from the group.")
    else
      flash[:error] = translate("The zip code could not be removed.")
    end
    redirect_to :back
  end
  
  def edit
    @group = Group.find(params[:id])
  end
  
  def index
    @groups = Group.all
    session[:group_id] = nil
  end
  
  def new
    @group = Group.new
  end
  
  def show
    @group = Group.find(params[:id])
    session[:group_id] = @group.id
  end
  
  def create
    @group = Group.new(params[:group].permit(:max_prizes))
    if @group.save
      @group.assemble(params[:zip_list], params[:admin_list])
      flash[:notice] = translate("Group saved successfully.")
      redirect_to groups_path
    else
      flash[:error] = translate("Group failed to save.")
      redirect_to :back
    end
  end
  
  def update
    @group = Group.find(params[:id])
    if @group.update(params[:group].permit(:max_prizes))
      flash[:notice] = translate("Group updated successfully.")
      redirect_to group_path(@group)
    else
      flash[:error] = translate("Group failed to update.")
      redirect_to :back
    end
  end
end
