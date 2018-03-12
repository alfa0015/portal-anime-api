require 'rails_helper'

RSpec.describe "Ractions", type: :request do
  describe "GET /ractions" do
    it "works! (now write some real specs)" do
      get ractions_path
      expect(response).to have_http_status(200)
    end
  end
end
