class Code < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  belongs_to :group
  
  validates_presence_of :code
  validates_uniqueness_of :code
  validates_presence_of :group_id
  validate :board_num_if_board
  validate :valid_format
  
  mount_uploader :image, ImageUploader
  
  private
  
  def valid_format
    numbers = 0; letters = 0
    for char in code.split("")
      if char =~ /[0-9]/
        numbers += 1
      elsif char =~ /[A-Za-z]/
        letters += 1
      end
    end
    unless code.size == 5 and numbers == 3 and letters == 2
      errors.add(:invalid_format, "Codes must have a length \
        of 5 characters with 3 numbers and 2 letters.")
    end
  end
  
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
