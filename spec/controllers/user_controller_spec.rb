require 'rails_helper'

RSpec.describe UserController, type: :controller do

  describe "GET #activity" do
    it "returns http success" do
      get :activity
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #computers" do
    it "returns http success" do
      get :computers
      expect(response).to have_http_status(:success)
    end
  end

end
