class AddReviewedUserToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :reviewed_user, :integer
  end
end
