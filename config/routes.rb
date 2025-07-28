# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root to: 'home#profile'
  get 'profile/', to: 'home#profile'
  patch 'upload_avatar', to: 'users#upload_avatar'
  delete 'delete_avatar', to: 'users#delete_avatar'
end
