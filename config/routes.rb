Rails.application.routes.draw do
  resources :events
  resources :comments, only: [:create, :destroy]
  mount_devise_token_auth_for 'User', at: 'auth'

  resources :users do
    member do
      get :invites
      get :followers
    end
  end

  authenticated :user do
    root to: 'feed#index', as: 'feed'
  end
  unauthenticated :user do
    root 'feed#front'
  end

  match :follow, to: 'follows#create', as: :follow, via: :post
  match :unfollow, to: 'follows#destroy', as: :unfollow, via: :post
  match :like, to: 'likes#create', as: :like, via: :post
  match :unlike, to: 'likes#destroy', as: :unlike, via: :post
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
