class HomeController < ApplicationController
  before_action :authenticated, only: %i[index]

  def index
    Group.create(id: 5, name: 'No group', user_id: 1) if Group.all.where(id: 5).first.nil?
  end

  private

  helper_method :logged_in?

  def logged_in?
    !current_user.nil?
  end

  def authenticated
    return if logged_in?

    flash[:alert] = 'You need to login or sign up to access'
    redirect_to '/login'
  end
end
