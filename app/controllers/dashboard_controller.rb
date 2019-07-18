class DashboardController < ApplicationController
  before_action :get_auth_record, only: [:services, :set_auth]
  before_action :check_access, only: [:services]

  def index
    @computers = Computer.order(:created_at).paginate(page: params[:page], per_page: 30)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def services
  end

  # The Admin user CISCO credentials will be updated here
  def set_auth
    respond_to do |format|
      if @auth_record.update(auth_params)
        format.html { flash[:success] = "Credentials successfully updated." }
      else
        format.html { flash[:warning] = "Some Error occured while updating!" }
      end
      render :services
    end
  end

  private

    def auth_params
      params.require(:auth_record).permit(:api_client, :api_key)
    end

    def get_auth_record
      @auth_record ||= current_user.auth_record || current_user.build_auth_record
    end

    # This method will verify if the user is admin if not will redirect to dashboard
    def check_access
      unless policy(:dashboard).show?
        flash[:warning] = "You are not authorized to access that page!"
        redirect_to dashboard_index_path
      end
    end
end
