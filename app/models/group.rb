class Group < ActiveRecord::Base
  has_many :users
  has_many :zips
  has_many :codes
  has_many :prizes
  has_many :game_boards
  
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
end
