# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  def upload_avatar
    if params[:user][:avatar].present?
      current_user.avatar.attach(params[:user][:avatar])
      redirect_to root_path, notice: 'Uploaded avatar!'
    else
      redirect_to root_path, alert: 'Select file'
    end
  end

  def delete_avatar
    if current_user.avatar.attached?
      current_user.avatar.purge
      redirect_to root_path, notice: 'Photo removed!'
    else
      redirect_to root_path, alert: 'Photo is empty!'
    end
  end
end
