Rails.application.routes.draw do
  
  root 'pages#home'
  
  get '/home', to: 'pages#home'

  # A route that goes to a particular recipe and then LIKE
  # SO we shall build a nested route
  resources :recipes do
    member do
      post 'like'
    end
  end
  

  
  
  
end
