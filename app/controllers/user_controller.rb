class UserController < ApplicationController
  def activity
    @activities = current_user.user_activities.limit(10)
  end

  def computers
    @computers = current_user.computers.limit(10)
  end
end
