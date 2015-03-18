class TipsController < ApplicationController
  def create
    @tip = current_user.tips.new kind: params[:kind]
    if @tip.save
      if @tip.kind.eql? "skip_tour_tip"
        current_user.update skipped_tour: true
      end
      log_action("tips_create")
    else
      log_action("tips_create_fail")
    end
  end
end
