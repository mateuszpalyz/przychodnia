class Api::VisitsController < ApplicationController

  def show
    @patient = Patient.find(params[:id])
    @visits = @patient.visits
    render json: @visits
  end
end
