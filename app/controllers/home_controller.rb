# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!

  def profile
    @doctors = User.doctors
    @categories = Category.all
  end
end
