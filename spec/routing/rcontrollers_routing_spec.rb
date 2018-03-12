require "rails_helper"

RSpec.describe RcontrollersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/rcontrollers").to route_to("rcontrollers#index")
    end


    it "routes to #show" do
      expect(:get => "/rcontrollers/1").to route_to("rcontrollers#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/rcontrollers").to route_to("rcontrollers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/rcontrollers/1").to route_to("rcontrollers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/rcontrollers/1").to route_to("rcontrollers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/rcontrollers/1").to route_to("rcontrollers#destroy", :id => "1")
    end

  end
end
