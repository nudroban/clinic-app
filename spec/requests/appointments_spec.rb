require 'rails_helper'

RSpec.describe "Appointments", type: :request do
  let(:patient) { User.create!(first_name: 'John', last_name: 'Doe', phone: '1234567890', password: 'password') }
  let(:doctor) { User.create!(first_name: 'Doc', last_name: 'McStuff', phone: '0987654321', password: 'password', role: :doctor) }

  describe "GET /appointments" do
    it "shows patient appointments" do
      sign_in patient
      Appointment.create!(doctor: doctor, patient: patient, date: Date.today, time: Time.zone.parse('10:00'))
      get appointments_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /doctors/:doctor_id/appointments" do
    it "creates a new appointment" do
      sign_in patient
      expect {
        post doctor_appointments_path(doctor), params: { appointment: { date: Date.today, time: '11:00' } }
      }.to change(Appointment, :count).by(1)
      expect(response).to redirect_to(appointments_path)
    end
  end
end