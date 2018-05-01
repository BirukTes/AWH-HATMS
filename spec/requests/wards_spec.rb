require 'rails_helper'

RSpec.describe "Wards", type: :request do
  describe "GET /wards" do
    it "works! (now write some real specs)" do
      get wards_path
      expect(response).to have_http_status(200)
    end
  end
end
