class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :game_board
  
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
  
  def code_title
    Code.find(code_id).title
  end
  
  def code_image
    Code.find(code_id).image
  end
  
  def self.redeem(code)
    _code = Code.find_by_code(code)
    unless _code and _code.is_a_board
      _code
    else
      nil
    end
  end
end
