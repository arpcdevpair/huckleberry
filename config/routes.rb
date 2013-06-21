Huckleberry::Application.routes.draw do
  devise_for :users

  root to: 'messages#index'

  resources :messages, only: [:show, :index, :create, :new ]

  controller :profiles do
    match 'profiles' => :index, as: :user, via: :get
    match 'profiles/:initials' => :show, as: :user, via: :get
  end

  controller :channels do
    match 'channels/:name' => :show, as: :channel, via: :get
  end
end
