Rails.application.routes.draw do
  root to:'posts#index'
  post '/posts/search', to: 'posts#search'
  get '/posts/show/:id', to: 'posts#show'
  get '/signup', to: 'users#signup'
  post '/users/create', to: 'users#create'
end

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
