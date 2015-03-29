module TipsHelper
  def context_validated? kind
    tip_auth? kind and still_learning? kind \
      and correct_device? kind and not current_user.skipped_tour
  end
  
  def correct_device? kind
    case kind
    when :user_profile_button_tip, :notes_button_tip, :games_button_tip, :social_button_tip
      not mobile?
    when :dropdown_button_tip
    	mobile?
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
    when :dropdown_button_tip, :user_profile_button_tip
      return current_user.tips.exists? kind: :elheroe_button_tip
    when :social_button_tip
    	return current_user.tips.exists? kind: :user_profile_button_tip
    when :notes_button_tip
    	return current_user.tips.exists? kind: :social_button_tip
    when :games_button_tip
    	return current_user.tips.exists? kind: :notes_button_tip
    when :global_tabs_button_tip
      return current_user.tips.
      	where(kind: [:games_button_tip, :dropdown_button_tip]).
      	present?
    when :skip_tour_tip
    	learned?
    end
  end 
  
  def learned?
  	learned = true
  	kinds = mobile? ? tip_kinds_mobile : tip_kinds
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
		[ :welcome_tip, :elheroe_button_tip, :tab_features_button_tip,
			:global_tabs_button_tip, :user_profile_button_tip,
			:games_button_tip, :notes_button_tip,
			:social_button_tip ]
	end
	
	def tip_kinds_mobile
		kinds = tip_kinds
		kinds << :dropdown_button_tip
		kinds.delete_if { |kind| kind.eql? :user_profile_button_tip }
	end
	
	def tip_defs
		{ welcome_tip: html_safe(translate("Welcome to El Heroe, this will be your home page for the site.") + " " +
        translate("It has articles and events that are close to you. Later, I'll show you how to choose a Drop") + " " +
        '<i class="fa fa-tint"></i>' + " " + translate("as your welcome screen.")),
        
			elheroe_button_tip: "This is the home button and will bring you back here from anywhere on the site.",
      
			user_profile_button_tip: "User Profile button: Manage your network size, language, and personal account settings.",
      
			social_button_tip: "Social: This is where you access social media on El Heroe, using Drops (explained later).",
      
			notes_button_tip: "Notes: Alerts on comments, invitations, sales inquiries, and much more.",
      
			games_button_tip: "Games: Click here for the best way to win prizes from El Heroe and other businesses in your area.",
      
			dropdown_button_tip: "Dropdown Menu: From here you can access your User Profile, Social, Notes, and Games.",
      
			skip_tour_tip: html_safe('<p>' + translate("Now that you've become more familiar with the site, feel free to end the tour by clicking this tip.") +
        '</p>' + translate("You can restart the tour at any time by visiting your account settings.")),
        
			global_tabs_button_tip: "Global Drops: Check out the unique drops people around the world have created.",
      
			tab_features_button_tip: "As an admin, you can add features to drops by clicking here.",
      
			tab_description_tip: html_safe("Drop " + '<i class="fa fa-tint"></i>' + ": " +
      "A combination of multiple basic features that mix together to form original views for different interests."),
      
			create_tab_tip: html_safe('<p>' + translate("Create a Drop") + " " + '<i class="fa fa-tint"></i>' + ":" + '</p>' +
				'<p>' + '1. ' + translate('Come up with an idea') + '</p>' +
				'<p>' + '2. ' + translate('Provide a name and icon') + '</p>' +
				'<p>' + '3. ' + translate('Add features for unique functionality') + '</p>' +
				'<p>' + '4. ' + translate('Await approval for originality and appropriateness') + '</p>' +
				'<p>' + '5. ' + translate('Start posting and communicating with like minded people in your Drop') + ' ' +
					'<i class="fa fa-tint"></i>' + '.' + '</p>')
			}
	end
end
