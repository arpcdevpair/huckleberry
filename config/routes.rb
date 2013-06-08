Huckleberry::Application.routes.draw do
  devise_for :users

  root to: 'messages#index'

  resources :messages, :only => [:show, :index, :create, :new ]
  resource :profiles, :as => :user, :only => :show
  controller :profiles do
    match 'profiles/:initials' => :show, :as => :user, :via => :get
  end
end
