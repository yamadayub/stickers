Rails.application.routes.draw do
  get 'static_pages/readme'
  root to:'tweets#index'
  get '/tweets/search', to: 'tweets#search'
  get '/tweets/timeline', to: 'tweets#timeline'
  get '/tweets/timeline_reload', to: 'tweets#timeline_reload'
  
  resources :posts, only: [:create, :show] do
    member do
      get :thumbsdown
      get :thumbsup
    end
  end
  
  get '/worst', to: 'posts#worst'
  get '/best', to: 'posts#best'
  
  get '/signup', to: 'users#signup'
  post '/users/create', to: 'users#create'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get '*anything' => 'errors#routing_error'

end

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
