CashHoppers::Application.routes.draw do
  root :to => 'pages#home'

  namespace :admin do
       get 'pages/index', :as => 'index'
      resources :applications
      resources :hops
      resources :hop_tasks
      resources :hop_ads

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

      resources :ads
      resources :hops do
        get :daily, :on => :collection
      end
    end
  end

  match '/auth/:service/callback' => 'services#add_zip'
  get 'services/add_zip', :to => 'services#add_zip'
 
  resources :services, :only => [:index, :create, :destroy]

  resources :ads
  resources :ad_types
end
