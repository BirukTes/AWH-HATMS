require 'rails_helper'

RSpec.describe "Specialities", type: :request do
  describe "GET /specialities" do
    it "works! (now write some real specs)" do
      get specialities_path
      expect(response).to have_http_status(200)
    end
  end
end
