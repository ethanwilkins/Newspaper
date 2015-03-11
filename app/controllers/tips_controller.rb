class TipsController < ApplicationController
  def create
    @tip = current_user.tips.new kind: params[:kind]
    if @tip.save
      log_action("tips_create")
    else
      log_action("tips_create_fail")
    end
  end
end
