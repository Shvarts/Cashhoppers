CashHoppers::Application.routes.draw do

  root :to => 'pages#home'

  namespace :admin do
    get 'pages/index', :as => 'index'
    resources :applications
  end

  get "pages/home"

  devise_for :users do
    namespace :API do
      post 'sessions' => 'sessions#create', :as => 'login'
      post 'sign_up' => 'sessions#sign_up', :as => 'sign_up'
      delete 'sessions' => 'sessions#destroy', :as => 'logout'
    end
  end

end
