class AdminController < ApplicationController
  def index
    Activity.log_action(current_user, request.remote_ip.to_s,
      ((current_user and current_user.admin) ? "admin_index" : "admin_index_fail"))
  end
end
