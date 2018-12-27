Rails.application.routes.draw do
  devise_for :users

  get 'searches/index'
  root to:'pages#home'

  post 'searches', to: 'searches#new'
  get 'searches/:id', to: 'searches#show'


  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end


end
