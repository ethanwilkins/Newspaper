module TipsHelper
  def context_validated? kind
    tip_auth? kind and still_learning? kind \
      and correct_device? kind and not current_user.skipped_tour
  end
  
  def correct_device? kind
    case kind
    when :user_profile_button_tip, :notes_button_tip, :games_button_tip
      not mobile?
    else
      true
    end
  end
  
  def correct_order? kind
    case kind
    when :welcome_tip
      return true
    when :elheroe_button_tip
      return current_user.tips.exists? kind: :welcome_tip
    when :tab_features_button_tip
      return current_user.tips.exists? kind: :elheroe_button_tip
    when :global_tabs_button_tip
      return current_user.tips.exists? kind: :games_button_tip
    when :skip_tour_tip
      return learned?
    end
  end
  
  def learned?
  	learned = true
  	for kind in tip_kinds
  		if current_user.tips.where(kind: kind).size < 1 # for testing, 3 for production
  			learned = false
  		end
  	end
  	return learned
  end
  
  # shows each tip 5 times per user
  def still_learning? kind
    current_user and current_user.tips.where(kind: kind).size < 1000 # for testing, 3 for production
  end
  
  # checks for privilege if necessary to see tip
  def tip_auth? kind
    case kind
    when :tab_features_button_tip
      return privileged?
    else
    	return current_user
    end
  end
  
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
	
	def tip_kinds
		[:welcome_tip, :elheroe_button_tip, :tab_features_button_tip,
			:global_tabs_button_tip, :user_profile_button_tip,
			:games_button_tip, :notes_button_tip]
	end
end
