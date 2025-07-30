require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { User.create!(first_name: 'John', last_name: 'Doe', phone: '1234567890', password: 'password') }

  describe "PATCH /upload_avatar" do
    it "uploads an avatar" do
      sign_in user
      file = fixture_file_upload(Rails.root.join('public', 'favicon.ico'), 'image/x-icon')
      patch upload_avatar_path, params: { user: { avatar: file } }
      expect(response).to redirect_to(root_path)
      expect(user.reload.avatar).to be_attached
    end
  end

  describe "DELETE /delete_avatar" do
    it "deletes the avatar" do
      sign_in user
      user.avatar.attach(io: File.open(Rails.root.join('public', 'favicon.ico')), filename: 'favicon.ico')
      delete delete_avatar_path
      expect(response).to redirect_to(root_path)
      expect(user.reload.avatar).not_to be_attached
    end
  end
end
