class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def policy
  end

  def about
  end

  def for_patient
  end

  def check
    unless params[:pesel] =~ /[0-9]{11}/
      flash[:error] = "PESEL o nieprawidłowym formacie"
      redirect_to for_patient_path  
    else
      @patient = Patient.find_by_pesel(params[:pesel])
      if @patient && @patient.authenticate(params[:password])
        @pat = @patient
        @visit = Visit.find_by_patient_id(@pat)
      else
        @patient = nil
        flash[:error] = "Niepoprawny PESEL lub hasło"
        redirect_to for_patient_path 
      end
    end
  end
end
