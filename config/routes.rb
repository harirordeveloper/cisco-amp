Rails.application.routes.draw do
  get 'user/activity'
  get 'user/computers'
  resources :dashboard do
    collection do
      get :services
      put :set_auth
    end
  end
  resources :computer
  devise_for :users

  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end
  root to: 'main#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
