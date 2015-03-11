module TipsHelper
	def inline_position(top=nil, right=nil, bottom=nil, left=nil)
		position = ""
		if top.present?
			position << "top:#{top}px;"
		elsif bottom.present?
			position << "bottom:#{bottom}px;"
		end
		if right.present?
			position << "right:#{right}px;"
		elsif left.present?
			position << "left:#{left}px;"
		end
		return position
	end
  
  def still_learning? kind
    current_user.tips.where(kind: kind).size < 5
  end
end
