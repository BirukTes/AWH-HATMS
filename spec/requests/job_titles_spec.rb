require 'rails_helper'

RSpec.describe "JobTitles", type: :request do
  describe "GET /job_titles" do
    it "works! (now write some real specs)" do
      get job_titles_path
      expect(response).to have_http_status(200)
    end
  end
end
