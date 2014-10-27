class AdminController < ApplicationController
  def index
    Activity.log_action(current_user, request.remote_ip.to_s, "admin_index")
  end
end
