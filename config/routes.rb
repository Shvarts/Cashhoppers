CashHoppers::Application.routes.draw do



  root :to => 'pages#home'

  namespace :admin do
       get 'pages/index', :as => 'index'
      resources :applications
      resources :hops
      resources :hop_tasks
      resources :ads
      match "hoppers/find_hopper"
      match "hoppers/hopper_list"
      match '/hoppers/search_hoppers' => "hoppers#search_hoppers"
      match '/hoppers/search_hopper' => "hoppers#search_hopper"
      match '/messages/message_history' => "messages#message_history"
      match '/messages/show' => "messages#show"
      delete '/messages/destroy' => "messages#destroy"
      post '/messages/create_email' => "messages#create_email"
      post '/messages/create_message' => "messages#create_message"
      match '/messages/email_history' => "messages#email_history"
      match '/messages/send_email' => "messages#send_email"
      get '/messages/close_grid' => "messages#close_grid"
      match '/messages/wice_grid' => "messages#wice_grid"
      match '/messages/find_users' => "messages#find_users"
      match '/messages/email_tool' => "messages#email_tool"
      match '/messages/message_tool' => "messages#message_tool"
      match '/messages/text_tool' => "messages#text_tool"
      match '/search/current_hops' => "search#current_hops"
      match '/search/hops_archive' => "search#hops_archive"

      post 'hops/close/:id', to: 'hops#close' , :as=>'close'
  end


  get "pages/home"

  devise_for :users do
    namespace :api do
      post 'sessions' => 'sessions#create', :as => 'login'
      post 'sign_up' => 'sessions#sign_up', :as => 'sign_up'
      delete 'sessions' => 'sessions#destroy', :as => 'logout'
      post 'confirm_registration' => 'sessions#confirm_registration'

      post 'sign_in_via_service' => 'sessions#sign_in_via_service'

      resources :ads, :only => :index
      resources :hops do
        get :daily, :on => :collection
      end
      get 'get_hop_tasks' => 'hops#get_hop_tasks'
    end
  end

  match '/auth/:service/callback' => 'services#add_zip'
  get 'services/add_zip', :to => 'services#add_zip'
 
  resources :services, :only => [:index, :create, :destroy]
  resources :ad_types

  get 'friends', :to => 'friends#friends'
  get 'find_friends', :to => 'friends#find_friends'
end
