# frozen_string_literal: true

class RecommendationsController < ApplicationController
  before_action :authenticate_user!

  def show
    @recommendation = Recommendation.find(params[:id])
  end

  def new
    @appointment = Appointment.find(params[:appointment_id])
    @recommendation = @appointment.build_recommendation
    authorize! :create, @recommendation
  end

  def create
    @appointment = Appointment.find(params[:appointment_id])
    @recommendation = @appointment.build_recommendation(recommendation_params)
    authorize! :create, @recommendation

    if @recommendation.save
      @appointment.update(active: false)
      redirect_to appointments_path, notice: 'Recommendation was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def recommendation_params
    params.require(:recommendation).permit(:content)
  end
end
