class ComputerController < ApplicationController
  before_action :fetch_computer, only: :show

  def show
  end

  private

    def fetch_computer
      @computer ||= Computer.friendly.find params[:id]
    end
end
