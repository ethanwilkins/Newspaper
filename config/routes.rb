Rails.application.routes.draw do
  
  # user routes
  
  get 'sessions/new'

  post 'sessions/create'

  get 'sessions/destroy'
  
  get 'admin', to: 'admin#index'
  
  get 'users/:user_id/gallery', to: 'users#gallery', as: 'gallery'
  
  
  # post routes
  
  get "posts/up_vote/:id", to: "posts#up_vote", as: "up_vote_post"
  
  get "posts/un_vote/:id", to: "posts#un_vote", as: "un_vote_post"
  
  delete 'posts/:post_id/finalize_sale/:folder_id', to: 'posts#finalize_sale', as: 'finalize_sale'
  
  delete 'posts/destroy/:id', to: 'posts#destroy', as: 'destroy_post'
  
  
  # articles routes
  
  delete 'articles/destroy/:id', to: 'articles#destroy', as: 'destroy_article'
  
  get 'tabs/:tab_id/articles/new', to: 'articles#new', as: 'new_tab_article'
  
  get 'subtabs/:subtab_id/articles/new', to: 'articles#new', as: 'new_subtab_article'
  
  get 'articles/ad_edit/:id', to: 'articles#ad_edit', as: 'ad_edit'

  get 'articles/approve/:id', to: 'articles#approve', as: 'approve_article'

  get 'articles/deny/:id', to: 'articles#deny', as: 'deny_article'
  
  get 'articles/pending', as: 'pending_articles'
  
  get 'articles/ad_index', as: 'ad_index'
  
  
  # events
  
  get 'events/:event_id/going', to: 'events#going', as: 'going'
  
  get 'events/:event_id/not_going', to: 'events#not_going', as: 'not_going'
  
  get 'events/:event_id/attendance', to: 'events#attendance', as: 'attendance'

  get 'events/approve/:id', to: 'events#approve', as: 'approve_event'
  
  get 'subtabs/:subtab_id/events/new', to: 'events#new', as: 'new_subtab_event'
  
  get 'tabs/:tab_id/events/new', to: 'events#new', as: 'new_tab_event'

  get 'events/deny/:id', to: 'events#deny', as: 'deny_event'
  
  get 'events/pending', as: 'pending_events'
  
  
  # message routes
  
  post 'messages/create', as: 'messages'
  
  get 'folders/new/:post_id/:user_id', to: 'folders#new', as: 'inquire'
  
  get 'folders/new/:user_id', to: 'folders#new', as: 'new_folder'
  
  get 'messages/new_messages'
  
  
  # comment routes
  
  post 'comments/create', as: 'comments'
  
  get 'comments/show/:id', to: 'comments#show', as: 'comment'
  
  
  # notes routes
  
  get 'notes/select', as: "notes_select"
  
  get 'notes/new/:id', to: 'notes#new', as: 'new_note'
  
  get 'notes/new_notes'
  
  
  # tab routes
  
  put 'tabs/update'
  
  patch 'subtabs/update/:id', to: 'subtabs#update', as: 'subtab'
  
  post 'subtabs/create', as: 'subtabs'
  
  delete 'tabs/destroy/:id', to: "tabs#destroy", as: 'destroy_tab'

  get 'tabs/approve/:id', to: 'tabs#approve', as: 'approve_tab'

  get 'tabs/deny/:id', to: 'tabs#deny', as: 'deny_tab'

  get 'subtabs/approve/:id', to: 'subtabs#approve', as: 'approve_subtab'

  get 'subtabs/deny/:id', to: 'subtabs#deny', as: 'deny_subtab'
  
  delete 'subtabs/destroy/:id', to: "subtabs#destroy", as: 'destroy_subtab'
  
  get 'tabs/pending', as: 'pending_tabs'
  
  
  # feedback routes
  
  put 'feedbacks/update'
  
  post 'feedbacks/create', as: 'feedback'
  
  delete 'feedbacks/destroy/:id', to: "feedbacks#destroy", as: 'destroy_feedback'
  
  get 'users/:user_id/feedbacks/new', to: 'feedbacks#new', as: 'new_user_feedback'
  
  get 'posts/:post_id/feedbacks/new', to: 'feedbacks#new', as: 'new_post_feedback'
  
  get 'events/:event_id/feedbacks/new', to: 'feedbacks#new', as: 'new_event_feedback'
  
  get 'articles/:article_id/feedbacks/new', to: 'feedbacks#new', as: 'new_article_feedback'
  
  get 'comments/:comment_id/feedbacks/new', to: 'feedbacks#new', as: 'new_comment_feedback'
  
  get 'tabs/:tab_id/feedbacks/new', to: 'feedbacks#new', as: 'new_tab_feedback'
  
  post 'features/request_invite', as: 'request_invite'
  
  
  # feature routes
  
  get 'features/switch_global', as: 'switch_global'
  
  get "features/page_jump/:tab_id", to: 'features#page_jump', as: 'page_jump'
  
  get "features/cherry_pick", to: 'features#cherry_pick', as: 'cherry_pick'
  
  get "features/un_cherry_pick", to: 'features#un_cherry_pick', as: 'un_cherry_pick'
  
  delete 'features/destroy/:id', to: 'features#destroy', as: 'destroy_feature'
  
  get 'features/insert_pre_feature_grid', as: 'insert_pre_feature_grid'
  
  post 'features/create', as: 'features'
  
  
  # groups
  
  delete 'groups/destroy/:id', to: 'groups#destroy', as: 'destroy_group'
  
  put 'groups/remove_member'
  
  put 'groups/add_member'
  
  put 'groups/remove_zip'
  
  put 'groups/add_zip'
  
  
  # game_board routes
  
  delete 'codes/destroy/:id', to: 'codes#destroy', as: 'destroy_code'
  
  delete 'game_boards/destroy/:id', to: 'game_boards#destroy', as: 'destroy_board'
  
  get 'game_boards/reset/:id', to: 'game_boards#reset', as: 'reset'
  
  get 'game_boards', to: 'game_boards#index', as: 'boards'
  
  post 'game_boards/create', as: 'game_boards'
  
  post 'cards/create', as: 'cards'
  
  delete 'codes/clear', as: 'clear'
  
  get 'codes/code_data'
  
  
  # activity routes
  
  get 'activities/:id/get_location', to: 'activities#get_location', as: 'get_location'
  
  get 'activities/unique_locations', as: 'unique_locations'
  
  get 'activities/unique_visits', as: 'unique_visits'
  
  
  # translation routes 
  
  put 'translations/update'
  
  delete 'translations/destroy/:id', to: 'translations#destroy', as: 'destroy_translation'
  
  get 'translations/requests', as: 'translation_reqs'
  
  
  # search routes
  
  get "search/search/:query", to: "search#search", as: "tagged"
  
  get "search/search", as: "search"
  
  
  # page routes
  
  get "pages/more", as: "more"
  
  get "pages/back", as: "back"
  
  
  # tips
  
  post 'tips/create', as: 'tips_create'
  
  
  # polls
  
  get 'tabs/:tab_id/polls/new', to: 'polls#new', as: 'new_tab_poll'
  
  get 'users/:user_id/polls/new', to: 'polls#new', as: 'new_user_poll'
  
  get 'polls/add_choice/:choice_num', to: 'polls#add_choice', as: 'add_choice'
  
  post 'polls/:poll_id/up_vote/:choice_id', to: 'polls#up_vote', as: 'up_vote_choice'
  
  post 'polls/:poll_id/down_vote/:choice_id', to: 'polls#down_vote', as: 'down_vote_choice'
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  
  
  resources :codes
  resources :posts
  resources :banners
  resources :loading_gifs
  resources :translations
  resources :sports_matches
  resources :activities
  resources :feedbacks
  resources :articles
  resources :groups
  resources :events
  resources :notes
  resources :polls
  
  resources :game_boards do
    resources :cards
  end
  
  resources :folders do
    resources :messages
  end
  
  resources :tabs do
    resources :features
    resources :subtabs do
      resources :features
    end
  end

  resources :users do
    resources :features
  end
  
  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
