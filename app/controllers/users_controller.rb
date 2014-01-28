class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :show, :index, :destroy]
  before_action :correct_user,   only: [:edit, :update, :show]
  before_action :admin_user,     only: [:index,:destroy, :new, :create]

  def index
    @users = User.order('users.created_at DESC').all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Konto zostało utworzone pomyślnie"
      redirect_to users_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Konto zostało zaktualizowane"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def calendar
    @visits = Visit.unscoped.order('next_visit').where(user_id: current_user.id)
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Konto usunięte."
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name,
                                   :surname,
                                   :email,
                                   :specialty,
                                   :age,
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
