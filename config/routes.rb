Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  root 'users/top' #トップ画面

  # ユーザー側のルーティング
  namespace :user do
    resources :products, only: [:index, :show]
    resources :users, only: [:show, :edit, :update, :destroy] do
      resources :cart_items, only: [:index, :create, :update, :destroy] do
        collection do
          delete 'destroy_all' #destroy_allをcollectionで追加
        end
      resources :orders, only:[:index, :create, :new, :show]
      end
      resources :deliveries, only: [:index, :create, :edit, :update, :destroy]
    end
    get 'orders/:id/confirm' => 'orders#confirm' #注文確認画面
    get 'confirm' => 'users#confirm' #退会確認ページ
    get 'thanks' => 'orders#thanks' #購入完了ページ
  end

  # 管理者側のルーティング
  namespace :admin do
    get 'admins/top' => 'admins#top' #管理者トップページ
    resources :products
    resources :genres [:index, :create, :edit, :update, :destroy]
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      resources :orders, only: [:index, :show ,:update]
    end
  end
end
