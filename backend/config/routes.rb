Rails.application.routes.draw do
  resources :room_messages
  resources :rooms
  resources :users, only: [:new, :create, :uploadphoto]


  root 'sessions#welcome'
  get 'welcome', to: 'sessions#welcome'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'authorized', to: 'sessions#page_requires_login'
  post 'sendmessage', to: 'room_messages#new_message'
  post 'change_email', to: 'users#set_email'
  delete 'rooms', to: 'rooms#destroy'
end
