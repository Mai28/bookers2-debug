Rails.application.routes.draw do
  devise_for :users
  resources :books
  resources :users,only: [:show,:index,:edit,:update]
  root  'homes#top'
  get 'home/about' =>'homes#about'
  delete '/books' => 'books#destroy'

end
