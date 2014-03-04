class UsersController < ApplicationController
  before_action :signed_in_user,  only: [:index, :edit, :update, :destroy]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: :destroy

  def index
    @users = User.paginate(page: params[:page], :per_page => 5)
  end

  def show
    @user = User.find(params[:id])
    @acts = @user.acts.paginate(page: params[:page], :per_page => 5)
  end

  def new
    if signed_in?
      redirect_to root_url
    else
      @user = User.new
    end
  end

  def create
    if signed_in?
      redirect_to root_url
    else
      @user = User.new(user_params)
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to the Sample App!"
        redirect_to root_url
      else
        render 'new'
      end
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    if User.find(params[:id]) == current_user
      redirect_to(root_url, notice: "You cannot delete your own account.")
    else
      User.find(params[:id]).destroy
      flash[:success] = "User deleted."
      redirect_to users_url
    end
  end

  private

    # Forces using strong parameters in the create action
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :weight, :gender)
    end

    # Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
