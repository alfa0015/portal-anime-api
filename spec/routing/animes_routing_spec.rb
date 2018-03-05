require "rails_helper"

RSpec.describe Api::V1::AnimesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/api/v1/animes").to route_to("api/v1/animes#index")
    end


    it "routes to #show" do
      expect(:get => "/api/v1/animes/1").to route_to("api/v1/animes#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/api/v1/animes").to route_to("api/v1/animes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/v1/animes/1").to route_to("api/v1/animes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/v1/animes/1").to route_to("api/v1/animes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/v1/animes/1").to route_to("api/v1/animes#destroy", :id => "1")
    end

  end
end
