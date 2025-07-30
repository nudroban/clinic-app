require 'rails_helper'

RSpec.describe "Recommendations", type: :request do
  let(:category) { Category.create!(name: "Therapist") }
  let(:doctor)   { User.create!(first_name: 'Doc', last_name: 'McStuff', phone: '0987654321', password: 'password', role: :doctor, category: category) }
  let(:patient) { User.create!(first_name: 'John', last_name: 'Doe', phone: '1234567890', password: 'password') }
  let(:appointment) { Appointment.create!(doctor: doctor, patient: patient, date: Date.today, time: Time.zone.parse('10:00')) }

  describe "GET /recommendations/:id" do
    it "shows recommendation" do
      rec = Recommendation.create!(appointment: appointment, content: 'Take rest')
      sign_in patient
      get recommendation_path(rec)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /appointments/:appointment_id/recommendation" do
    it "creates recommendation" do
      sign_in doctor
      expect {
        post appointment_recommendation_path(appointment), params: { recommendation: { content: 'Take rest' } }
      }.to change(Recommendation, :count).by(1)
      expect(response).to redirect_to(appointments_path)
    end
  end
end