require "rails_helper"

RSpec.describe SpecialitiesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/specialities").to route_to("specialities#index")
    end

    it "routes to #new" do
      expect(:get => "/specialities/new").to route_to("specialities#new")
    end

    it "routes to #show" do
      expect(:get => "/specialities/1").to route_to("specialities#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/specialities/1/edit").to route_to("specialities#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/specialities").to route_to("specialities#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/specialities/1").to route_to("specialities#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/specialities/1").to route_to("specialities#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/specialities/1").to route_to("specialities#destroy", :id => "1")
    end

  end
end
