class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :user_id
      t.integer :post_id
      t.integer :article_id
      t.integer :comment_id
      t.integer :event_id
      t.integer :tab_id
      t.integer :stars
      t.text :review
      t.timestamps
    end
  end
end
