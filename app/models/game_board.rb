class GameBoard < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  has_many :cards, dependent: :destroy
  
  validates_presence_of :group_id
  validate :unique_to_user
  
  def card_names
    return Card.names(self.board_number)
  end
  
  def you_won!
    prize = {won: false}
    Prize.wins.each do |key, win|
      a_win = true
      for num in win # validates win if combo met
        unless cards.find_by_board_loc(num).redeemed
          a_win = false
        end
      end
      combo_type = Prize.get_combo_type(key)
      # finds available prizes in group if a winning combo was met
      available = group.available_prizes(combo_type, user) if a_win
      # assigns a matching prize of the group to the user if any are available
      if available and available.last.update user_id: user.id, winning_combo: key.to_s
        prize[:won] = true; prize[:combo] = combo_type
        Note.notify(nil, user, :you_won)
        break
      end
    end
    return prize
  end
  
  def self.repopulate(zip_code = nil)
    for board in zip_code.present? ? GameBoard.where(zip_code: zip_code) : GameBoard.all
      board.cards.destroy_all
      board.populate
    end
  end
  
  def populate
    board_loc = 1
    for image in Dir.glob("app/assets/images/cards/board_#{board_number.to_s}/bw/*.png")
      cards.create image: "cards/board_#{board_number.to_s}/bw/#{image.split('/').last}",
        board_loc: board_loc, name: Card.get_name(image)
      board_loc += 1
    end
  end
  
  def self.redeem(code)
    _code = Code.find_by_code(code)
    if _code and _code.is_a_board
      _code
    else
      nil
    end
  end
  
  private
  
  def unique_to_user
    user = User.find_by_id(user_id)
    if user and user.game_boards.exists? code_id: code_id
      errors.add(:code_already_redeemed, "You've already redeemed this code.")
    end
  end
end