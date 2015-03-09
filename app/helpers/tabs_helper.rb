module TabsHelper
	def invited?
		member = @tab.members.find_by_user_id(current_user.id)
	  if member and member.made_member
	  	return true
	  else
	  	return false
	  end
	end
end
