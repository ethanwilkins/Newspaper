class GameBoard < ActiveRecord::Base
  belongs_to :user
  has_many :cards, dependent: :destroy
  
  def you_won!
    wins = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16],
            [1, 5, 9, 13], [2, 6, 10, 14], [3, 7, 11, 15], [4, 8, 12, 16]]
    winner = false
    for win in wins
      not_a_win = false
      for num in win
        unless cards.find_by_board_loc(num).redeemed
          not_a_win = true
        end
      end
      winner = true unless not_a_win
    end
    return winner
  end
  
  def populate
    board_loc = 1
    for image in Dir.glob("app/assets/images/cards/board_#{board_number.to_s}/bw/*.png")
      cards.create image: "cards/board_#{board_number.to_s}/bw/#{image.split('/').last}",
        board_loc: board_loc
      board_loc += 1
    end
  end
  
  def board_number
    begin
      Code.find(code_id).board_number
    rescue
      nil # nil to the rescue!
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