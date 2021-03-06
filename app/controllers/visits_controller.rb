class VisitsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :show]
  before_action :admin_user,     only: [:destroy, :edit, :update]

  def show
    @visit = Visit.find(params[:id])
    @patient = Patient.find(@visit.patient_id)
  end

  def new
    @visit = Visit.new
    @pat = params[:patient]
  end

  def create
    patient = Patient.find(params[:patient])
    @visit = patient.visits.new(user_params)
    @visit.user = current_user
    if @visit.save
      flash[:success] = "Wizyta została utworzona pomyślnie"
      redirect_to patient_path(patient)
    else
      @pat = params[:patient]
      render :action => 'new'
    end
  end

  def edit
    @visit = Visit.find(params[:id])
  end

  def update
    @visit = Visit.find(params[:id])
    if @visit.update_attributes(user_params)
      flash[:success] = "Wizyta została zaktualizowana"
      redirect_to @visit
    else
      render 'edit'
    end
  end

  def destroy
    @visit = Visit.find(params[:id])
    @patient = Patient.find(@visit.patient_id)
    @visit.destroy
    flash[:success] = "Wizyta została usunięta."
    redirect_to @patient
  end

  private

    def user_params
      params.require(:visit).permit(:cause,
                                   :psymptom,
                                   :time_symptom,
                                   :illness_chage,
                                   :symptom_type,
                                   :time_illness,
                                   :freq_illness,
                                   :care,
                                   :dsymptom,
                                   :illness,
                                   :drugs,
                                   :next_visit,
                                   :has_been_changed,
                                   :user_id,
                                   :patient_id)
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
