require 'sidekiq/web'

Rails.application.routes.draw do
	mount Sidekiq::Web => '/sidekiq'

	root to: 'home#index'
  resources :users
	resources :tickets
end
