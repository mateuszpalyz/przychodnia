class PatientsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :show, :index, :edit, :update, :search, :find, :index_my]
  before_action :admin_user,     only: [:index,:destroy]

  def index
    @patients = Patient.paginate(page: params[:page], order: 'created_at DESC')
  end

  def index_my
    @visits = Visit.where(user_id: current_user.id)
    @patients = Patient.where(id: @visits.map(&:patient_id)).paginate(page: params[:page], order: 'created_at DESC')
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(user_params)
    if @patient.save
      flash[:success] = "Karta pacjenta została utworzona pomyślnie"
      if current_user.admin?
        redirect_to patients_path
      else
        redirect_to @patient
      end
    else
      render 'new'
    end
  end

  def show
    @patient = Patient.find(params[:id])
    @visits = @patient.visits.paginate(page: params[:page])
    $CURRENT_PATIENT = params[:id]
  end

  def edit
    @patient = Patient.find(params[:id])
  end

  def update
    @patient = Patient.find(params[:id])
    if @patient.update_attributes(user_params)
      flash[:success] = "Karta pacjenta została zaktualizowana"
      redirect_to @patient
    else
      render 'edit'
    end
  end

  def destroy
    Patient.find(params[:id]).destroy
    flash[:success] = "Karta pacjenta została usunięta."
    redirect_to patients_path
  end

  def search
  end

  def find
    unless params[:pesel] =~ /[0-9]{11}/
      flash[:error] = "PESEL o nieprawidłowym formacie"
      redirect_to search_patients_path  
    else
      @patient = Patient.find_by_pesel(params[:pesel])
      if @patient
        redirect_to @patient
      else
        redirect_to search_patients_path, notice: "Brak pacjenta o PESELu: #{params[:pesel]}"
      end
    end
  end

   private

    def user_params
      params.require(:patient).permit(:name,
                                   :surname,
                                   :pesel,
                                   :password,
                                   :password_confirmation)
    end

    def signed_in_user
      redirect_to signin_url, notice: "Żądana strona wymaga uprzedniego zalogowania się" unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to user_path(current_user), notice: "Żądana strona wymaga uprzedniego zalogowania się jako inny użytkownik" unless current_user?(@user)
    end

    def admin_user
      redirect_to root_url, notice: "Żadana akcja wymaga uprawnień administratora" unless current_user.admin?
    end
end
