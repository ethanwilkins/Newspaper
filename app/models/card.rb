class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :code
  belongs_to :game_board
  
  def self.remove_expired(cards)
    for card in cards
      if DateTime.now.to_i - card.created_at.to_i > 2592000
        card.destroy
      end
    end
  end
  
  def redeemed_img
    new_img = ""
    image.split('/').each do |string|
      unless string == "bw"
        if new_img.empty?
          new_img << string
        else
          new_img << "/" + string
        end
      else
        new_img << "/color"
      end
    end
    return new_img
  end
  
  def self.redeem(code, board_num)
    _code = Code.find_by_code(code)
    unless _code and _code.is_a_board
      _code if _code.board_number == board_num
    end
  end
end
