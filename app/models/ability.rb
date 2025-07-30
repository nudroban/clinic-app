# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    if user.is_a?(AdminUser)
      can :manage, :all
      return
    end

    if user.doctor?
      can :read, Appointment, doctor_id: user.id
      can :manage, Recommendation, appointment: { doctor_id: user.id }
    elsif user.patient?
      can :read, User, role: 'doctor'
      can :read, Appointment, patient_id: user.id
      can :create, Appointment
      can :read, Recommendation, appointment: { patient_id: user.id }
    end
  end
end
