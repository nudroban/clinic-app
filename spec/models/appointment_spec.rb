require 'rails_helper'

RSpec.describe Appointment, type: :model do
  let(:doctor) { User.create!(first_name: 'Doc', last_name: 'McStuff', phone: '0987654321', password: 'password', role: :doctor) }
  let(:patient) { User.create!(first_name: 'John', last_name: 'Doe', phone: '1234567890', password: 'password') }

  it "is invalid without date" do
    appointment = Appointment.new(doctor: doctor, patient: patient, time: Time.zone.parse('10:00'))
    expect(appointment).to be_invalid
    expect(appointment.errors[:date]).to be_present
  end

  it "prevents doctor time conflicts" do
    Appointment.create!(doctor: doctor, patient: patient, date: Date.today, time: Time.zone.parse('10:00'))
    conflict = Appointment.new(doctor: doctor, patient: patient, date: Date.today, time: Time.zone.parse('10:00'))
    expect(conflict).to be_invalid
    expect(conflict.errors.full_messages.join).to match(/already busy/)
  end

  it "limits active appointments to ten" do
    10.times do |i|
      Appointment.create!(doctor: doctor, patient: patient, date: Date.today + i, time: Time.zone.parse('10:00'))
    end
    extra = Appointment.new(doctor: doctor, patient: patient, date: Date.today + 11, time: Time.zone.parse('11:00'))
    expect(extra).to be_invalid
    expect(extra.errors.full_messages.join).to match(/maximum appointments/)
  end

  it "returns display name" do
    appointment = Appointment.new(doctor: doctor, patient: patient, date: Date.today, time: Time.zone.parse('12:00'))
    expect(appointment.display_name).to include(patient.full_name)
  end
end
