require 'rails_helper'

RSpec.describe "diagnoses", type: :request do
  describe "GET /diagnoses" do
    it "works! (now write some real specs)" do
      get diagnoses_path
      expect(response).to have_http_status(200)
    end
  end
end
