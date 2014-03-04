class ActsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @act = current_user.acts.build(act_params)
    @act.completed = DateTime.new(params[:completed_input][:year].to_i, 
          params[:completed_input][:month].to_i, 
          params[:completed_input][:day].to_i, 
          params[:completed_input][:hour].to_i,
          params[:completed_input][:minute].to_i, 
          params[:completed_input][:second].to_i).change(:offset => "-0600")
    if @act.save
      flash[:success] = "You completed the " + @act.activity.name + " activity!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @act.destroy 
    redirect_to root_url
  end

  private

    def act_params
      params.require(:act).permit(:minutes, :activity_id)
    end

    def correct_user
      @act = current_user.acts.find_by(id: params[:id])
      redirect_to root_url if @act.nil?
    end
end
