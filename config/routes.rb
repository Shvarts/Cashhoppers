require_relative "../app/controllers/API/sessions_controller.rb"
require 'base64'
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
      get 'sign_up' => 'sessions#sign_up', :as => 'sign_up'
      delete 'sessions' => 'sessions#destroy', :as => 'logout'
    end
  end


  match '/auth/:service/callback' => 'services#add_zip'

  get 'services/add_zip', :to => 'services#add_zip'
 
  resources :services, :only => [:index, :create, :destroy]

end
