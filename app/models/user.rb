class User < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  has_many :game_boards, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  # validations for creation of user
  validates :name, presence: true
  validates :password, presence: true
  validates_confirmation_of :password
  validates_uniqueness_of :name

  def self.authenticate(name, password)
    user = find_by_name(name.downcase)
    if user && password == user.password
      user
    else
      nil
    end
  end
end
