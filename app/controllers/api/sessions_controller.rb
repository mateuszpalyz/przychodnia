class Api::SessionsController < ApplicationController

  protect_from_forgery except: :create

  def create
    user = User.find_by(email: params[:email].downcase)
    json = Array.new(1, Hash.new)
    if user && user.authenticate(params[:password])
      json[0]['login'] = user.id
    else
      json[0]['login'] = -1
    end
    render json: json
  end

  def loginpatient
    patient = Patient.find_by(pesel: params[:pesel])
    json = Array.new(1, Hash.new)
    if patient && patient.authenticate(params[:password])
      json[0]['login'] = patient.id
    else
      json[0]['login'] = -1
    end
    render json: json
  end
  
end
