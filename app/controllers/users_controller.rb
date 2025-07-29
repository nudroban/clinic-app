# frozen_string_literal: true

class UsersController < ApplicationController
  def upload_avatar
    if params[:user][:avatar].present?
      current_user.avatar.attach(params[:user][:avatar])
      redirect_to profile_path(current_user), notice: 'Uploaded avatar!'
    else
      redirect_to profile_path(current_user), alert: 'Select file'
    end
  end

  def delete_avatar
    if current_user.avatar.attached?
      current_user.avatar.purge
      redirect_to profile_path(current_user), notice: 'Photo removed!'
    else
      redirect_to profile_path(current_user), alert: 'Photo is empty!'
    end
  end
end
