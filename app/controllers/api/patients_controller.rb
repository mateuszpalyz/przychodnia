class Api::PatientsController < ApplicationController

  def index
    @patients = Patient.all
    render json: @patients
  end

  def show
  	@visits = Visit.where(user_id: params[:id])
    @patients = Patient.where(id: @visits.map(&:patient_id))
    render json: @patients
  end

  def one
  	patient = Patient.find(params[:id])
  	render json: patient
  end

end
