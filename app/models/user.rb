class User < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  attr_accessible :name, :password
  has_many :cards, :dependent => :destroy
  has_many :articles, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  # validations for creation of user
  validates :name, :presence => true
  validates :password, :presence => true
  validates_confirmation_of :password
  validates_uniqueness_of :name

  def self.authenticate(name, password)
    user = find_by_name(name)
    if user && password == user.password
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password = BCrypt::Engine.hash_secret(password, salt)
    end
  end
end