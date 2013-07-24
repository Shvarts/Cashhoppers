require 'will_paginate/array'
CashHoppers::Application.routes.draw do

  root :to => 'pages#home'

  namespace :admin do

    get 'pages/index', :as => 'index'
    resources :applications

    #hops
    resources :hops, only: [:create]
    get 'regular_hops',                    to: 'hops#regular'
    get 'daily_hops',                      to: 'hops#daily'
    get 'current_hops',                    to: 'hops#current'
    get 'archived_hops',                   to: 'hops#archived'
    get 'hop/:id',                         to: 'hops#show',              as: 'hop'
    get 'hops/new_regular',                to: 'hops#new_regular',       as: 'new_regular_hop'
    get 'hops/new_daily',                  to: 'hops#new_daily',         as: 'new_daily_hop'
    get 'hop/:id/edit_regular',            to: 'hops#edit_regular',      as: 'edit_regular_hop'
    get 'hop/:id/edit_daily',              to: 'hops#edit_daily',        as: 'edit_daily_hop'
    delete 'hop/:id',                      to: 'hops#destroy',           as: 'hop'
    put 'hop/:id',                         to: 'hops#update',            as: 'hop'
    post 'close_hop/:id',                  to: 'hops#close',             as: 'close_hop'

    resources :hop_tasks, only: [:new, :edit, :create, :update, :destroy, :index]

    resources :ads

    match "hoppers/find_hopper"
    match "hoppers/hopper_list"
    match '/hoppers/search_hoppers' => "hoppers#search_hoppers"
    get '/hoppers/search_by_name' => 'hoppers#search_by_name'
    get '/hoppers/search_by_id' => 'hoppers#search_by_id'
    get '/hoppers/search_by_zip' => 'hoppers#search_by_zip'
    get '/hoppers/search_by_hop' => 'hoppers#search_by_hop'


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
    match '/messages/find_hop' => "messages#find_hop"
    match '/messages/find_zip' => "messages#find_zip"
    match '/messages/text_tool' => "messages#text_tool"

  end

  namespace :api do
    post 'sessions' => 'sessions#create', :as => 'login'
    post 'sign_up' => 'sessions#sign_up', :as => 'sign_up'
    delete 'sessions' => 'sessions#destroy', :as => 'logout'
    post 'confirm_registration' => 'sessions#confirm_registration'

    post 'sign_in_via_service' => 'sessions#sign_in_via_service'

    get 'ads/get_ads' => 'ads#index'

    #hops
    get 'hops/regular',                    to: 'hops#regular'
    get 'hops/daily',                      to: 'hops#daily'
    post 'hops/assign',                    to: 'hops#assign'
    get 'hop/get_tasks',                   to: 'hops#get_tasks'

    #users hop tasks
    post 'task/submit',                    to: 'user_hop_tasks#create'
    get 'tasks/get_friends_hop_tasks',     to: 'user_hop_tasks#friends_hop_tasks'

    get 'friends/get_friends', to: 'friends#get_friends'
    get 'friends/get_requested_friends', to: 'friends#get_requested_friends'
    get 'friends/get_pending_friends', to: 'friends#get_pending_friends'
    post 'friends/send_request', to: 'friends#send_request'
    post 'friends/accept_request', to: 'friends#accept_request'
    post 'friends/decline_request', to: 'friends#decline_request'
    post 'friends/cancel_request', to: 'friends#cancel_request'
    post 'friends/delete_friend', to: 'friends#delete_friend'

    get 'users/get_users', to: 'users#index'
    get 'users/get_my_info', to: 'users#get_my_info'
    get 'users/get_user_info', to: 'users#get_user_info'
    post 'users/update_profile', to: 'users#update_profile'

    post 'tasks/get_events_list', to: 'user_hop_tasks#events_list'
    post 'tasks/create_task', to: 'user_hop_tasks#create'
  end

  devise_for :users
  get 'hop/:id/edit_regular',            to: 'hops#edit_regular',      as: 'edit_regular_hop'
  get 'user/:id',                        to: 'users#profile',          as: 'user'

  match '/auth/:service/callback' => 'services#add_zip'
  get 'services/add_zip', :to => 'services#add_zip'
 
  resources :services, :only => [:index, :create, :destroy]
  resources :ad_types

  get 'friends', to: 'friends#friends'
  get 'find_friends', to: 'friends#find_friends'
  post 'friends/create_request', to: 'friends#create_request'
  post 'friends/cancel_request', to: 'friends#cancel_request'
  post 'friends/accept_request', to: 'friends#accept_request'
  post 'friends/decline_request', to: 'friends#decline_request'
  post 'friends/delete_friend', to: 'friends#delete_friend'
end
