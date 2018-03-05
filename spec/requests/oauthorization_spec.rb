require 'rails_helper'
describe Api::V1::AccessTokenController, type: :request do

  describe "POST   /api/v1/oauth/token(.:format)" do

    context "datos validos" do

      before :each do
        @user = FactoryBot.create(:user)
        post oauth_token_path, params: { email:@user.email,password:@user.password,grant_type:"password" }
      end

      it{	expect(response).to have_http_status(:ok) }

      it{ change(@user.tokens,:count).by(1) }

      it "Manda los atributos del menu" do
        json = JSON.parse(response.body)
        expect(json.keys).to contain_exactly("access_token","token_type","expires_in","refresh_token","created_at")
      end

    end

    context "datos credenciales invalidas" do

      before :each do
        @user = FactoryBot.create(:user)
        post oauth_token_path, params: { email:@user.email,password:"asdasd",grant_type:"password" }
      end

      it{	expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["error"]).to_not be_empty
      end

    end

  end

end
