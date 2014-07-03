class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :game_board
  
  validates :code_id, presence: true
  
  def title
    Code.find(code_id).title if code_id
  end
  
  def image
    Code.find(code_id).image if code_id
  end
  
  def self.redeem(code)
    _code = Code.find_by_code(code)
    unless _code.is_a_board
      _code
    else
      nil
    end
  end
end
