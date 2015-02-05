class AdminController < ApplicationController
  def index
    log_action(((current_user and current_user.admin) ? "admin_index" : "admin_index_fail"))
    session[:group_id] = nil
  end
end
