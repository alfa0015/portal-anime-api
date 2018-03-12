require 'rails_helper'

RSpec.describe "Rcontrollers", type: :request do
  describe "GET /rcontrollers" do
    it "works! (now write some real specs)" do
      get rcontrollers_path
      expect(response).to have_http_status(200)
    end
  end
end
