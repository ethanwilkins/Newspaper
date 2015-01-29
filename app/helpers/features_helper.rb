module FeaturesHelper
  def has_feature? action
    unless action.is_a? Array
      if (@tab and @tab.features.exists? action: action) \
        or (@subtab and @subtab.features.exists? action: action)
        return true
      else
        return false
      end
    else
      if (@tab and @tab.features.where(action: action).present?) \
        or (@subtab and @subtab.features.where(action: action).present?)
        return true
      else
        return false
      end
    end
  end
end
