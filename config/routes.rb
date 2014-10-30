Rails.application.routes.draw do
  get 'sessions/new'

  post 'sessions/create'

  get 'sessions/destroy'
  
  post 'subtabs/create', as: 'subtabs'
  
  post 'cards/create', as: 'cards'
  
  delete 'codes/clear', as: 'clear'
  
  delete 'tabs/destroy/:id', to: "tabs#destroy", as: 'destroy_tab'
  
  delete 'codes/destroy/:id', to: 'codes#destroy', as: 'destroy_code'
  
  delete 'game_boards/destroy/:id', to: 'game_boards#destroy', as: 'destroy_board'
  
  delete 'articles/destroy/:id', to: 'articles#destroy', as: 'destroy_article'
  
  get 'game_boards/reset/:id', to: 'game_boards#reset', as: 'reset'
  
  get "hashtags/search/:query", to: "hashtags#search", as: "tagged"
  
  get "posts/up_vote/:id", to: "posts#up_vote", as: "up_vote_post"
  
  get "posts/un_vote/:id", to: "posts#un_vote", as: "un_vote_post"
  
  get 'comments/show/:id', to: 'comments#show', as: 'comment'
  
  get 'articles/ad_edit/:id', to: 'articles#ad_edit', as: 'ad_edit'

  get 'events/approve/:id', to: 'events#approve', as: 'approve_event'

  get 'events/deny/:id', to: 'events#deny', as: 'deny_event'

  get 'tabs/approve/:id', to: 'tabs#approve', as: 'approve_tab'

  get 'tabs/deny/:id', to: 'tabs#deny', as: 'deny_tab'

  get 'subtabs/approve/:id', to: 'subtabs#approve', as: 'approve_subtab'

  get 'subtabs/deny/:id', to: 'subtabs#deny', as: 'deny_subtab'
  
  get 'notes/notify/:id', to: 'notes#notify', as: 'notify_user'
  
  get 'posts/translation_requests', as: 'translation_reqs'
  
  get 'events/pending', as: 'pending_events'
  
  get "hashtags/search", as: "search"
  
  post 'game_boards/create', as: 'game_boards'
  
  post 'comments/create', as: 'comments'
  
  get 'admin', to: 'admin#index'
  
  get 'articles/ad_index', as: 'ad_index'
  
  get 'tabs/pending', as: 'pending_tabs'
  
  get "pages/more", as: "more"
  
  get "pages/back", as: "back"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end
  
  resources :codes
  resources :posts
  resources :banners
  resources :translations
  resources :articles
  resources :events
  resources :notes
  
  resources :tabs do
    resources :subtabs
  end

  resources :users do
    resources :game_boards do
      resources :cards
    end
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
