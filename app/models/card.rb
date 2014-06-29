class Card < ActiveRecord::Base
  belongs_to :user
  validates :code, numericality: true
  
  def title
    case self.code
      when 123
        "Aligator"
    end
  end
  
  def picture
    case self.code
      when 123
        "cards/aligator.png"
    end
  end
  
  def redeem
    codes = [123, 1234, 1245]
    if codes.include? self.code
      true
    end
  end
end
