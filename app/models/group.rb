class Group < ActiveRecord::Base
  has_many :users
  has_many :zips
  has_many :codes
  has_many :prizes
  has_many :game_boards
  
  def add_prizes(combo_type, amount)
    for i in amount
      prizes.create(combo_type: combo_type)
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
end
