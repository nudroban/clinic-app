# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |_ex|
    redirect_to root_path, alert: 'Access Denied'
  end
end
