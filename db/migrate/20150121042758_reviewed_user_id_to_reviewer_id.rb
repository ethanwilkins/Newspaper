class ReviewedUserIdToReviewerId < ActiveRecord::Migration
  def change
    rename_column :feedbacks, :reviewed_user_id, :reviewer_id
  end
end
