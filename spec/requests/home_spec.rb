require 'rails_helper'

RSpec.describe "Homes", type: :request do
  let(:user) { User.create!(first_name: 'John', last_name: 'Doe', phone: '1234567890', password: 'password') }

  describe "GET /" do
    it "returns http success when user signed in" do
      sign_in user
      get root_path
      expect(response).to have_http_status(:success)
    end

    it "redirects guest to sign in" do
      get root_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
