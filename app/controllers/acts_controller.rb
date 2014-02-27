class ActsController < ApplicationController
  before_action :signed_in_user

  def create
    @act = current_user.acts.build(act_params)
    @act.completed = DateTime.civil(params[:completed_input][:year].to_i, 
          params[:completed_input][:month].to_i, 
          params[:completed_input][:day].to_i, 
          params[:completed_input][:hours].to_i,
          params[:completed_input][:minutes].to_i, 
          params[:completed_input][:seconds].to_i)
    if @act.save
      flash[:success] = "You completed the " + @act.activity.name + " activity!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
    if current_user == @act.user
      @act.destroy
    else
      redirect_to root_url
    end
  end

  private

    def act_params
      params.require(:act).permit(:minutes, :activity_id)
    end
end
