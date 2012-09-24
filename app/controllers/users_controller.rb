class UsersController < ApplicationController
  before_filter :authenticate_user!
  def update_visit
    countries = params[:countries]
    countries.each do |country|
      unless current_user.visit?(country)
        current_user.visits.create(:country => country)
      end
    end
    current_user.visits.each do |visit|
      visit.destroy unless countries.include?(visit.country)
    end
    redirect_to root_path
  end
end
