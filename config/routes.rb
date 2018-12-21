Rails.application.routes.draw do
  get 'searches/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to:'pages#home'
  post 'searches', to: 'searches#search'
end
