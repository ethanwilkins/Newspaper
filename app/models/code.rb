class Code < ActiveRecord::Base
  validates :code, presence: true
  validates :is_a_board, presence: true
  
  validate :board_num_if_board, on: :create
  
  mount_uploader :image, ImageUploader
  
  def board_num_if_board
    if is_a_board and board_number.nil?
      errors.add(:code, "Boards need a number.")
    end
  end
end
