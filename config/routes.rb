# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :users, skip: [:registrations]

  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    patch 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  root to: 'projects#index'

  get 'wares/list' => 'wares#list', as: :list
  get 'wares/machine_list' => 'wares#machine_list', as: :machine_list

  get 'services/list' => 'services#list', as: :services_list

  resources :services do
    collection do
      patch :sort
    end
  end
  resources :extras
  resources :projects
  resources :wares do
    collection do
      patch :sort
    end
  end
  resources :project_extra_lines do
    collection do
      patch :sort
    end
  end
  resources :customers
  resources :quotations
  resources :invoices
  resources :payments
  resources :expense_accounts
  resources :machines
  resources :companies

  get '/change_locale', to: 'application#change_locale', as: :change_locale

  # A SUPPRIMER
  get 'projects/bin/:id' => 'projects#bin', as: :bin
  get 'invoices/paid/:id' => 'invoices#paid', as: :paid

  get "/pages/:page" => "pages#show"

  get "/machines/refresh_content/:id" => "machines#refresh_content", as: :refresh_machine
  get "/projects/refresh_content/:id" => "projects#refresh_content", as: :refresh_project

  get 'projects/duplicate/:id' => 'projects#duplicate', as: :duplicate
  post 'projects/duplicate/:id' => 'projects#duplicate'

end