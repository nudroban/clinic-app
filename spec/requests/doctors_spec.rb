require 'rails_helper'

RSpec.describe "Doctors", type: :request do
  let(:patient) { User.create!(first_name: 'John', last_name: 'Doe', phone: '1234567890', password: 'password') }
  let(:category) { Category.create!(name: "Therapist") }
  let(:doctor)   { User.create!(first_name: 'Doc', last_name: 'McStuff', phone: '0987654321', password: 'password', role: :doctor, category: category) }

  describe "GET /doctors" do
    it "returns http success" do
      sign_in patient
      get doctors_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /doctors/:id" do
    it "shows doctor profile" do
      sign_in patient
      get doctor_path(doctor)
      expect(response).to have_http_status(:success)
    end
  end
end