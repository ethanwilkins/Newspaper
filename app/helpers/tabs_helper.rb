module TabsHelper
	def invited?
		@tab.members.exists? user_id: current_user.id
	end
end
