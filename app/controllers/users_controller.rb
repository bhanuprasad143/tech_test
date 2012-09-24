class UsersController < ApplicationController
  before_filter :authenticate_user!
  def update_visit
    country = params[:country]
    unless current_user.visit?(country)
      current_user.visits.create(:country => country)
    end
    redirect_to root_path
  end
end
