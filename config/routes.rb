Rails.application.routes.draw do
  get 'search/search'
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get '/home/about' => 'homes#about'
  post 'follow/:id' => 'relationships#follow', as: 'follow'
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
  resources :books, only: [:index, :create, :show, :edit, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :followings, :followers
    end
  end
end
