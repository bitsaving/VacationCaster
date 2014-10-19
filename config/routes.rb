require 'resque/scheduler/server'

Vacaycaster::Application.routes.draw do
  resources :searches

  root "pages#home"    
  get "home", to: "pages#home", as: "home"
  get "inside", to: "pages#inside", as: "inside"
  
    
  devise_for :users
  
  namespace :admin do
    root "base#index"
    resources :users
  end
  
	mount Resque::Server.new, :at => '/resque', :constraints => lambda { |req|
    req.env['warden'].authenticated? and req.env['warden'].user.admin?
  }

end
