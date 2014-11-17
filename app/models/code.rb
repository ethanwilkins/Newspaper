class Code < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  
  validates :code, presence: true
  validates :code, uniqueness: true, numericality: true
  validates :zip_code, presence: true, numericality: true
  validate :board_num_if_board, :unique_cards
  
  mount_uploader :image, ImageUploader
  
  def unique_boards
    if is_a_board and Code.where("is_a_board = ? and board_number = ?", true, board_number).present?
      errors.add(:board_code_exists, "You already have a code for that board.")
    end
  end
  
  def unique_cards
    if !is_a_board and Code.where("is_a_board = ? and board_number = ? and board_loc = ?",
      is_a_board, board_number, board_loc).present?
      errors.add(:card_code_exists, "You already have a code for that card.")
    end
  end
  
  def board_num_if_board
    if is_a_board and board_number.nil?
      errors.add(:board_needs_number, "Boards require a number.")
    end
  end
end
