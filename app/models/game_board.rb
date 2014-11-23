class GameBoard < ActiveRecord::Base
  belongs_to :user
  has_many :cards, dependent: :destroy
  has_many :prizes, dependent: :destroy
  
  def card_names
    return Card.names(self.board_number)
  end
  
  def you_won!
    winner = false
    user = User.find(user_id)
    Prize.wins.each do |key, win|
      a_win = true
      for num in win
        unless cards.find_by_board_loc(num).redeemed
          a_win = false
        end
      end
      if a_win and Prize.not_won_before(key.to_s, board_number)
        user.prizes.create winning_combo: key.to_s, board_number: board_number
        Note.notify(nil, user, :you_won)
        winner = true
      elsif a_win
        winner = true
      end
    end
    return winner
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
        board_loc: board_loc, name: Card.names(board_number)[board_loc - 1].to_s
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
end