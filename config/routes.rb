# frozen_string_literal: true

Rails.application.routes.draw do

  resources :customer_machine_lines
  resources :machines
  resources :companies
  devise_for :users, skip: [:registrations]

  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    patch 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  root to: 'projects#index'

  resources :services
  resources :extras
  resources :projects
  resources :wares
  resources :project_extra_lines
  resources :customers
  resources :quotations
  resources :invoices
  resources :payments

  get '/change_locale', to: 'application#change_locale', as: :change_locale

  get 'projects/bin/:id' => 'projects#bin', as: :bin

  get "/pages/:page" => "pages#show"

end
