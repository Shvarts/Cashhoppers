require 'will_paginate/array'
CashHoppers::Application.routes.draw do

  root :to => 'pages#home'
  get 'pages/hoppers_activity'


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
    post 'hops/print_hop_to_pdf',          to: 'hops#print_hop_to_pdf',      as: 'print_hop_to_pdf'
    post 'hops/print_hop_list_to_pdf',     to: 'hops#print_hop_list_to_pdf',      as: 'print_hop_list_to_pdf'
    post 'hops/import_from_excel',         to: 'hops#import_from_excel',      as: 'import_from_excel'
    post 'hops/print_hop_to_excel',     to: 'hops#print_hop_to_excel',      as: 'print_hop_to_excel'
    post 'hops/print_hops_to_excel',     to: 'hops#print_hops_to_excel',      as: 'print_hops_to_excel'

    #hop_tasks
    resources :hop_tasks

    #prizes
    resources :prizes

    #ads
    resources :ads

    match "hoppers/find_hopper"
    match "hoppers/hopper_list"
    match '/hoppers/search_hoppers' => "hoppers#search_hoppers"
    get '/hoppers/search_by_name' => 'hoppers#search_by_name'
    get '/hoppers/search_by_id' => 'hoppers#search_by_id'
    get '/hoppers/search_by_zip' => 'hoppers#search_by_zip'
    get '/hoppers/search_by_hop' => 'hoppers#search_by_hop'
    post '/hoppers/hopper_to_pdf' => 'hoppers#hopper_to_pdf'
    get '/hoppers/export_to_excel' => 'hoppers#export_to_excel'

    #messages
    get 'messages/email_tool'
    get 'messages/message_tool'
    post 'messages/message_create'
    get 'messages/hops_list'
    get 'messages/users_list'
    get 'messages/email_history'
    get 'messages/message_history'
    delete 'messages/destroy_message'

  end

  namespace :api do
    post 'sessions',                       to: 'sessions#create',        as: 'login'
    post 'sign_up',                        to: 'sessions#sign_up',       as: 'sign_up'
    delete 'sessions',                     to: 'sessions#destroy',       as: 'logout'
    post 'confirm_registration',           to: 'sessions#confirm_registration'
    post 'sign_in_via_service',            to: 'sessions#sign_in_via_service'

    get 'ads/get_ads' => 'ads#index'

    #hops
    get 'hops/regular',                    to: 'hops#regular'
    get 'hops/daily',                      to: 'hops#daily'
    post 'hops/assign',                    to: 'hops#assign'
    get 'hop/get_tasks',                   to: 'hops#get_tasks'
    get 'hop/get_hop',                     to: 'hops#get_hop_by_id'
    get 'hop/score',                       to: 'hops#score'
    get 'hops/yesterdays_winner',          to: 'hops#yesterdays_winner'

    #users hop tasks
    post 'task/submit',                    to: 'user_hop_tasks#create'
    get 'tasks/get_friends_hop_tasks',     to: 'user_hop_tasks#friends_hop_tasks'
    get 'tasks/get_all_hoppers_hop_tasks', to: 'user_hop_tasks#all_hoppers_hop_tasks'
    post 'task/like',                      to: 'user_hop_tasks#like'
    get 'task/likes_count',                to: 'user_hop_tasks#likes_count'
    post 'task/comment',                   to: 'user_hop_tasks#comment'
    get 'task/get_comments',               to: 'user_hop_tasks#comments'
    post 'task/notify_by_share',           to: 'user_hop_tasks#notify_by_share'
    get 'task/get_user_hop_task_by_id',    to: 'user_hop_tasks#get_user_hop_task_by_id'

    #friends
    get 'friends/get_friends',             to: 'friends#get_friends'
    get 'friends/get_requested_friends',   to: 'friends#get_requested_friends'
    get 'friends/get_pending_friends',     to: 'friends#get_pending_friends'
    post 'friends/send_request',           to: 'friends#send_request'
    post 'friends/accept_request',         to: 'friends#accept_request'
    post 'friends/decline_request',        to: 'friends#decline_request'
    post 'friends/cancel_request',         to: 'friends#cancel_request'
    post 'friends/delete_friend',          to: 'friends#delete_friend'

    #messages
    post 'messages/send_message',          to: 'messages#send_message_to_friends'
    get 'messages/synchronize',            to: 'messages#synchronize_messages'
    get 'messages/thread',                 to: 'messages#get_users_messages_thread'
    get 'messages/history',                to: 'messages#messages_history'
    delete 'messages/remove_message',      to: 'messages#remove_message'

    #users
    get 'users/get_users',                 to: 'users#index'
    get 'users/get_my_info',               to: 'users#get_my_info'
    get 'users/get_user_info',             to: 'users#get_user_info'
    post 'users/update_profile',           to: 'users#update_profile'

    #events
    get 'notifications',                   to: 'notifications#get_events_list'
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

  post 'messages/create_message', to: 'messages#create_message'
  get 'messages/message_list', to: 'messages#message_list'
end
