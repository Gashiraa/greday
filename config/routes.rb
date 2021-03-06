# frozen_string_literal: true

Rails.application.routes.draw do

  resources :oils
  devise_for :users

  root to: 'projects#index'

  get 'wares/list' => 'wares#list', as: :list
  get 'wares/specific_list' => 'wares#specific_list', as: :specific_list
  get 'wares/maintenance_list' => 'wares#maintenance_list', as: :maintenance_list

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
  resources :partial_invoices
  resources :stock_wares


  get '/change_locale', to: 'application#change_locale', as: :change_locale

  # A SUPPRIMER
  get 'projects/bin/:id' => 'projects#bin', as: :bin
  get 'invoices/paid/:id' => 'invoices#paid', as: :paid

  get "/pages/:page" => "pages#show"

  get "/machines/refresh_content/:id" => "machines#refresh_content", as: :refresh_machine
  get "/projects/refresh_content/:id" => "projects#refresh_content", as: :refresh_project

  get 'projects/duplicate/:id' => 'projects#duplicate', as: :duplicate
  post 'projects/duplicate/:id' => 'projects#duplicate'

  get 'machines/duplicate/:id' => 'machines#duplicate', as: :duplicate_machine
  post 'machines/duplicate/:id' => 'machines#duplicate'

end