class ChangeToReviewedUserId < ActiveRecord::Migration
  def change
    rename_column :feedbacks, :reviewed_user, :reviewed_user_id
  end
end
