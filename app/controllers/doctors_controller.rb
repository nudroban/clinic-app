# frozen_string_literal: true

class DoctorsController < UsersController
  before_action :authenticate_user!
  load_and_authorize_resource :doctor, class: 'User'

  def index
    @categories = Category.includes(doctors: { avatar_attachment: :blob }).all
  end

  def show; end
end
