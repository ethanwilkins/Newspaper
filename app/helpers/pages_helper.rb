module PagesHelper
  def current_loading_gif
    current = if @user_shown and @user.features.exists? \
                action: :custom_loading and @user.loading_gifs.last
                @user.loading_gifs.last.image
              elsif @tab_shown and @tab.features.exists? \
                action: :custom_loading and @tab.loading_gifs.last
                @tab.loading_gifs.last.image
              elsif @subtab_shown and @subtab.features.exists? \
                action: :custom_loading and @subtab.loading_gifs.last
                @subtab.loading_gifs.last.image
              elsif LoadingGif.default
                LoadingGif.default
              else
                "loading.gif"
              end
    return current
  end
end
