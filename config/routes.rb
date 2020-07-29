# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  root 'home#index'

  scope 'app' do
    get '/', to: 'dashboard#index', as: 'user_root'
    resources :categories, except: %i[show] do
      put :favorite, to: 'favorite_category#update'
    end

    resources :accounts do
      put :favorite, to: 'favorite_account#update'
    end

    resources :reports, only: %i[index] do
      get :yearly_expenses, to: 'reports/yearly_expenses#index', on: :collection
    end

    resources :accounts
    resources :records
    resources :transfers, only: :create
    namespace :reports do
      resources :category_reports, only: [:index]
    end
  end
end
