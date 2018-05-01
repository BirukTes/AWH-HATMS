require "rails_helper"

RSpec.describe WardsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/wards").to route_to("wards#index")
    end

    it "routes to #new" do
      expect(:get => "/wards/new").to route_to("wards#new")
    end

    it "routes to #show" do
      expect(:get => "/wards/1").to route_to("wards#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/wards/1/edit").to route_to("wards#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/wards").to route_to("wards#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/wards/1").to route_to("wards#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/wards/1").to route_to("wards#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/wards/1").to route_to("wards#destroy", :id => "1")
    end

  end
end
