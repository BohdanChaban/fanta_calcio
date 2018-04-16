Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { registrations: 'registrations' }
  root to: 'home#index'

  resources :teams, only: [:index, :new, :create]
  resources :players, only: [:index, :show, :update]
  resources :clubs, only: [:index, :show] do
    get 'fixtures', on: :member
  end
  resources :squads, only: [:index, :show, :new, :create, :edit, :update]
end
