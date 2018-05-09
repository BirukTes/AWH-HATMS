require 'rails_helper'

RSpec.describe ReportsController, type: :controller do

  describe "GET #ward_list" do
    it "returns http success" do
      get :ward_list
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #medications_list" do
    it "returns http success" do
      get :medications_list
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #discharge_list" do
    it "returns http success" do
      get :discharge_list
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #patient_card" do
    it "returns http success" do
      get :patient_card
      expect(response).to have_http_status(:success)
    end
  end

end
