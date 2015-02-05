class Code < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  has_many :game_boards
  belongs_to :group
  
  validates_presence_of :code
  validates_uniqueness_of :code
  validate :board_num_if_board
  validate :group_assignment
  validate :valid_format
  
  mount_uploader :image, ImageUploader
  
  def self.card_codes_redeemed
    _redeemed = []
    for _code in self.where.not(is_a_board: true)
      if _code.cards.present?
        _redeemed << _code
      end
    end
    return _redeemed
  end
  
  def self.game_board_codes_redeemed
    _redeemed = []
    for _code in self.where(is_a_board: true)
      if _code.game_boards.present?
        _redeemed << _code
      end
    end
    return _redeemed
  end
  
  def self.redeemed(not_redeemed=nil)
    _redeemed = []
    _not_redeemed = []
    for _code in self.all
      if _code.cards.present? or _code.game_boards.present?
        _redeemed << _code
      else
        _not_redeemed << _code
      end
    end
    if not_redeemed
      return _not_redeemed
    else
      return _redeemed
    end
  end
  
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
      errors.add(:invalid_format, "Codes must have a length of 5 characters with 3 numbers and 2 letters.")
    end
  end
  
  def group_assignment
    if is_a_board and group_id.present?
      errors.add(:group_id_not_required, "Group assignment is for card codes only.")
    elsif not is_a_board and group_id.nil?
      errors.add(:group_id_required, "Card codes must be assigned to a group.")
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
    elsif not is_a_board and board_number.present?
      errors.add(:board_number_only_for_boards, "Board numbers are only for board codes.")
    end
  end
end
