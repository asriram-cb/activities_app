class ActionsController < ApplicationController
  before_action :signed_in_user

  def create
    @action = current_user.actions.build(action_params)
    if @action.save
      flash[:success] = "You completed the " + @action.activity.name + " activity!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
    if current_user == @action.user
      @action.destroy
    else
      redirect_to root_url
    end
  end

  private

    def action_params
      params.require(:action).permit(:completed, :minutes)
    end
end
