class Group < ActiveRecord::Base
  has_many :users
  has_many :zips
  has_many :codes
  has_many :prizes
  has_many :game_boards
  
  validate :only_one_default
  
  def self.default
    return Group.where(default: true).last
  end
  
  def available_prizes(combo_type, user=nil, return_size=nil)
    prizes_by_combo = prizes.where(combo_type: combo_type)
    won_by_user = prizes_by_combo.where(user_id: user.id) if user
    available = prizes_by_combo.where(user_id: nil)
    if return_size
      return available.present? ? available.size : 0
    elsif user and won_by_user.empty? and available.present?
      return available
    else
      return nil
    end
  end
  
  def add_prizes(combo_type, amount)
    if combo_type and amount
      for i in 1..amount.to_i
        prizes.create(combo_type: combo_type)
      end
    end
  end
  
  def assemble(zip_list, admin_list)
    if zip_list
      zip_list.split(", ").each do |zip|
        _zip = Zip.find_by_zip_code(zip.to_i)
        if _zip
          _zip.update group_id: self.id
        end
      end
    end
    if admin_list
      admin_list.split(", ").each do |admin|
        _admin = User.find_by_name(admin)
        if _admin
          _admin.update group_id: self.id, admin: true
        end
      end
    end
  end
  
  def self.find_by_user(user)
    if user.zip_code.present?
      for group in self.all
        if group.zips.present? and group.zips.find_by_zip_code(user.zip_code)
          return group
        end
      end
    end
  end
  
  private
  
  def only_one_default
    if Group.where(default: true).present?
      errors.add(:only_one_default, "There can only be one default group.")
    end
  end
end
