# frozen_string_literal: true

class Appointment < ApplicationRecord
  belongs_to :doctor,  class_name: 'User'
  belongs_to :patient, class_name: 'User'

  has_one :recommendation, dependent: :destroy

  validates :date, :time, presence: true
  validate :doctor_available
  validate :doctor_appointments_limit, on: :create

  def doctor_appointments_limit
    return if doctor_id.blank?

    count = Appointment.where(doctor_id: doctor_id, active: true).count
    if count >= 10
      errors.add(:base, 'Doctor already has maximum appointments')
    end
  end

  def doctor_available
    return if doctor.blank? || date.blank? || time.blank?

    conflict = Appointment.where(doctor_id: doctor_id, date: date, time: time).where.not(id: id).exists?
    errors.add(:base, 'The doctor is already busy at this time.') if conflict
  end

  def display_name
    "#{patient.full_name} — #{date} #{time&.strftime('%H:%M')}"
  end
end
