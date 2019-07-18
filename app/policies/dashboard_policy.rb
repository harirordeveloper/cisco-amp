class DashboardPolicy < Struct.new(:user, :dashboard)
  def show?
    user.is_admin?
  end
end
