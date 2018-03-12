require "rails_helper"

RSpec.describe RactionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/ractions").to route_to("ractions#index")
    end


    it "routes to #show" do
      expect(:get => "/ractions/1").to route_to("ractions#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/ractions").to route_to("ractions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/ractions/1").to route_to("ractions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/ractions/1").to route_to("ractions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ractions/1").to route_to("ractions#destroy", :id => "1")
    end

  end
end
