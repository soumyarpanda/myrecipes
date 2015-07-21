Rails.application.routes.draw do
  
  root 'pages#home'
  
  get '/home', to: 'pages#home'

  # A route that goes to a particular recipe and then LIKE
  # So we shall build a nested route
  resources :recipes do
    member do
      post 'like'
    end
  end
  
  resources :chefs, except: [:new]
  
  get '/register', to: 'chefs#new'

  get '/login', to: 'logins#new'
  post '/login', to: 'logins#create'
  get '/logout', to: 'logins#destroy'
  
  
  
end
