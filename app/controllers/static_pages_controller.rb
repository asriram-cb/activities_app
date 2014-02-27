class StaticPagesController < ApplicationController
  def home
    @act = current_user.acts.build if signed_in?
  end

  def help
  end

  def about 
  end

  def contact
  end
end
