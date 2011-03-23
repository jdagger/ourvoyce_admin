Production::Application.routes.draw do

  match "/login" => "admins#login", :as => :login
  match "/logout" => "admins#logout", :as => :logout

  match "/users/filter/:filter" => "users#index"
  resources :users
  resources :corporations
  resources :medias
  resources :governments
  resources :current_questions

  match "/logs" => "error_logs#index"

  controller :stats do
    match "/stats(/:action)", :defaults => {:action => :index}
  end

  root :to => "admins#index"
end
