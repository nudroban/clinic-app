# frozen_string_literal: true

class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @appointments = if current_user.patient?
                      patient_appointments_scope
                    else
                      doctor_appointments_scope
                    end
  end

  def new
    @doctor = User.find(params[:doctor_id])
    @appointment = Appointment.new
  end

  def create
    @doctor = User.find(params[:doctor_id])
    @appointment = Appointment.new(appointment_params)
    @appointment.doctor = @doctor
    @appointment.patient = current_user

    if @appointment.save
      redirect_to appointments_path, notice: 'You made an appointment with a doctor!'
    else
      flash.now[:alert] = @appointment.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  private

  def patient_appointments_scope
    current_user.appointments_as_patient
                .includes(:doctor)
                .order(date: :asc, time: :asc)
  end

  def doctor_appointments_scope
    current_user.appointments_as_doctor
                .includes(:patient)
                .order(date: :asc, time: :asc)
                .where(active: true)
  end

  def appointment_params
    params.require(:appointment).permit(:date, :time, :notes)
  end
end
