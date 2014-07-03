class GameBoard < ActiveRecord::Base
  belongs_to :user
  has_many :cards, dependent: :destroy
  
  def self.redeem(code)
    _code = Code.find_by_code(code)
    if _code.is_a_board
      _code
    else
      nil
    end
  end
end
