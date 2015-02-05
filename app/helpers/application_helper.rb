module ApplicationHelper
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
end
