require 'rails_helper'

RSpec.describe Recommendation, type: :model do
  let(:doctor) { User.create!(first_name: 'Doc', last_name: 'McStuff', phone: '0987654321', password: 'password', role: :doctor) }
  let(:patient) { User.create!(first_name: 'John', last_name: 'Doe', phone: '1234567890', password: 'password') }
  let(:appointment) { Appointment.create!(doctor: doctor, patient: patient, date: Date.today, time: Time.zone.parse('10:00')) }

  it "is invalid without content" do
    rec = Recommendation.new(appointment: appointment)
    expect(rec).to be_invalid
    expect(rec.errors[:content]).to be_present
  end

  it "is valid with content" do
    rec = Recommendation.new(appointment: appointment, content: 'Take rest')
    expect(rec).to be_valid
  end
end
