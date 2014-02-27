class StaticPagesController < ApplicationController
  def home
    @action = current_user.actions.build if signed_in?
  end

  def help
  end

  def about 
  end

  def contact
  end
end
