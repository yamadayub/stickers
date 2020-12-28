Rails.application.routes.draw do
  get 'bookmarks/index'
  get 'bookmarks/create'
  get 'bookmarks/destroy'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  root to:'posts#random'
  get 'static_pages/about'
  get '/tweets/search', to: 'tweets#search'
  get '/tweets/timeline', to: 'tweets#timeline'
  get '/tweets/timeline_reload', to: 'tweets#timeline_reload'
  get '/random', to: 'posts#random'
  get '/tweets/mytimeline', to: 'tweets#mytimeline'
  get '/tweets/mytimeline_reload', to: 'tweets#mytimeline_reload'
  
  resources :posts, only: [:create, :show] do
    member do
      get :thumbsdown
      get :thumbsup
    end
  end
  
  resources :bookmarks, only: [:index, :create, :destroy ]
  
  get '/worst', to: 'posts#worst'
  get '/best', to: 'posts#best'
  
  get '*anything' => 'errors#routing_error'

end

