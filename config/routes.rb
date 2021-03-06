Pagekonect::Application.routes.draw do

  resources :cities

  resources :states do
    get :states, :on => :collection
  end

  mount Ckeditor::Engine => '/ckeditor'
  resources :dashboard, :only => ['index'] do
    collection do 
      get 'home'
      get 'about_us'
      get 'contact_us'
      get 'public'
      get 'business'
    end 
  end
  get "comments/create"

  concern :commentable do
    resources :comments
  end

  resources :events, concerns: :commentable
  resources :deals, concerns: :commentable, :member => {:get => 'deals'}
  resources :news, concerns: :commentable, :member => {:get => 'detail'}
  resources :videos, concerns: :commentable, :member => {:get => 'detail'}
  resources :local_ads, concerns: :commentable
  resources :uploads, concerns: :commentable do
    get 'preview', on: :collection
    get 'publish', on: :collection
  end

  namespace :admin do
    match '(*any)' , to: redirect('/states'), via: [:get, :post]
  end
  resources :search, only: :index
  
  get 'news/:id/detail' => 'news#detail', as: :news_detail

  resources :profiles do
    get 'upload_banner'
    get 'crop_banner'
    get 'view'
    member do
      get 'upload_avatar'
      post 'jpegcam_upload' #, to: 'profiles#upload_avatar', via: :all      
      get 'take_pic'
      get 'save_avatar'
    end
  end
  
  resources :pages do
    get 'share', on: :collection
    get 'show_url', on: :collection
  end

  get 'pages/:keyword/search' => 'pages#search', as: :page_search
  
  root :to => 'search#index'
  
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

  get '/home' => 'dashboard#home'

  get 'vote_up' => "vote#vote_up"
  get 'vote_down' => "vote#vote_down"
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
