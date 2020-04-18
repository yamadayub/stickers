Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get 'dislikes/create'
  get 'dislikes/destroy'
  root to:'tweets#index'
  get '/tweets/search', to: 'tweets#search'
  get '/tweets/timeline', to: 'tweets#timeline'
  
  resources :posts, only: [:create, :show] do
    member do
      get :thumbsdown
      get :thumbsup
    end
  end
  #get '/posts/show/:id', to: 'posts#show'
  #post '/posts/create', to: 'posts#create'
  
  get '/signup', to: 'users#signup'
  post '/users/create', to: 'users#create'
  
  resources :dislikes, only: [:create, :destroy] 
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

end

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
