Pagekonect::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  get "dashboard/home"
  get "comments/create"
  get "deals/deals"

  concern :commentable do
    resources :comments
  end
  resources :uploads
  resources :events, concerns: :commentable
  resources :news, concerns: :commentable, :member => {:get => 'detail'}
  resources :videos, concerns: :commentable
  
  get 'news/:id/detail' => 'news#detail', as: :news_detail
  
  resources :profiles do
    get 'upload_banner'
    get 'upload_avatar'
    get 'crop_banner'
  end
  
  resources :pages

  get 'pages/:keyword/search' => 'pages#search', as: :page_search
  
  get 'home/about_us' => 'home#about_us', as: :about_us
  
  root :to => 'pages#index'
  
  devise_for :users, :controllers => {
    :registrations => 'registrations',
    :passwords     => 'passwords',
    :sessions      => 'sessions',
    :confirmations => 'confirmations'
  }
  devise_scope :user do
    get '/login'  => 'sessions#new'
    get '/logout' => 'sessions#destroy'
  end

  get '/deals' =>  "deals#deals"
  get '/home' => 'dashboard#home'

  resources :contents do
    member do
      get 'vote_up'
      get 'vote_down'
    end
  end

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
