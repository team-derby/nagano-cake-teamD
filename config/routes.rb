Rails.application.routes.draw do
  devise_for :users
  resources :users do
  	resource :deliveries, only: [:index, :edit, :update, :destroy, :create]
  end
  resources :admins, only:
  resources :products do
  	resource :cart_items, only: [:create, :update, :destroy, :index]
  	resource :genres, only: [:index, :edit, :update, :destroy, :create]
  end
  resources :orders, only:
  resources :order_items, only:
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'user/thanks' => 'orders#thanks'
end
