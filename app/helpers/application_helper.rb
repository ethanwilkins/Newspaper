module ApplicationHelper
	def html_safe text
		text.html_safe
	end
	
  def time_ago(_time_ago)
    _time_ago = _time_ago + " ago"
    if _time_ago.include? "about"
    	_time_ago.slice! "about "
    end
    if _time_ago[0].to_i > 0 and _time_ago[1].to_i > 0
      _time_ago = _time_ago[0..2] + translate(_time_ago[3.._time_ago.size])
    elsif _time_ago[0].to_i > 0
      _time_ago = _time_ago[0..1] + translate(_time_ago[2.._time_ago.size])
    else
      _time_ago = translate _time_ago
    end
    return _time_ago
  end
  
  def text_shown(item, field)
    field = field.to_s
    if item.translations.present? and item.translations.find_by_field(field) \
      and (item.translations.find_by_field(field).english.present? \
      and item.translations.find_by_field(field).spanish.present?)
      if english?
        return item.translations.find_by_field(field).english
      else
        return item.translations.find_by_field(field).spanish
      end
    else
      return item.attributes[field]
    end
  end
  
  # to replace partial currently being used as a helper
  def embed word
    # if word =~ /\A#{URI::regexp}\z/ and word.include? "youtu" and !word.include? "user" and !word.include? "channel"
    #   word = word.slice 0...word.index("&") if word.include? "&"
    #   word.sub! "watch?v=", "embed/" if word.include? "watch?v="
    #   word.sub! "youtu.be", "www.youtube.com/embed" if word.include? "youtu.be"
    #   <iframe width="90%" height="315" src="word" frameborder="0" allowfullscreen>
    #   </iframe></br>
    # elsif word =~ /\A#{URI::regexp}\z/ or word.include? "http://" or word.include? ".se" and word != "in:"
    #   if word.include? ".jpg" or word.include? ".png" or word.include? ".gif"
    #     <div align="center"> image_tag word, width: "90%" </div>
    #   else
    #     unless word.size > 25
    #       link_to word + " ", word, target: :_blank
    #     else
    #       link_to word[0..25] + "... ", word, target: :_blank
    #     end
    #   end
    # elsif word.include? "@" and User.find_by_name(word.slice(word.index("@")+1..word.size))
    #   user = User.find_by_name(word.slice(word.index("@")+1..word.size))
    #   link_to "@" + user.name.capitalize, user_path(user.name)
    # else
    #   if word.size < 30
    #     word + " "
    #   else
    #     word[0..25] + "... "
    #   end
    # end
  end
end
