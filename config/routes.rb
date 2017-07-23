Rails.application.routes.draw do
  get '/.well-known/acme-challenge/:id' => 'pages#letsencrypt'

  mount_devise_token_auth_for 'User', at: 'auth'

  resources :users
  resources :cees
  resources :flavors
  resources :favorites
  resources :notes

  match "*path", to: redirect('/'), via: :all
end
