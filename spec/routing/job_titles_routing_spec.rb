require "rails_helper"

RSpec.describe JobTitlesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/job_titles").to route_to("job_titles#index")
    end

    it "routes to #new" do
      expect(:get => "/job_titles/new").to route_to("job_titles#new")
    end

    it "routes to #show" do
      expect(:get => "/job_titles/1").to route_to("job_titles#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/job_titles/1/edit").to route_to("job_titles#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/job_titles").to route_to("job_titles#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/job_titles/1").to route_to("job_titles#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/job_titles/1").to route_to("job_titles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/job_titles/1").to route_to("job_titles#destroy", :id => "1")
    end

  end
end
