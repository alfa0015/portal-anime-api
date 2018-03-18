require 'rails_helper'

RSpec.describe "Ractions", type: :request do

  let(:admin_header){
    {
      "Authorization":"bearer #{log_in_admin}"
    }
  }

  let(:user_header){
    {
      "Authorization":"bearer #{log_in}"
    }
  }

  let(:invalid_header){
    {
      "Authorization":"bearer"
    }
  }

  let(:create_attributes){
    {
      rcontroller_id:@rcontroller.id
    }
  }

  let(:valid_attributes){
    @raction = FactoryBot.build(:raction)
  }

  let(:update_attributes){
    {
      name:"new_name"
    }
  }

  before :each do
    @rcontroller = FactoryBot.create(:rcontroller)
  end

  describe "GET /api/v1/rcontrollers/:rcontroller_id/ractions" do

    context "with valid token & admin" do

      before :each do
        FactoryBot.create_list(:raction,30,create_attributes)
        get api_v1_rcontroller_ractions_path(@rcontroller), headers:admin_header, as: :json
      end

      it{	expect(response).to have_http_status(:ok) }

      it "response with current page" do
        headers = response.headers
        expect(headers["x-page"]).to eq(1)
      end

      it "response with correctly number records" do
        headers = response.headers
        expect(headers["x-total"]).to eq(Raction.count)
      end

      it "response with number records per page" do
        headers = response.headers
        expect(headers["x-per-page"]).to eq(25)
      end

      it "response with next page" do
        headers = response.headers
        expect(headers["next_page"]).to_not be_empty
      end

      it "response with prev page" do
        get response.headers["next_page"], headers:{"Authorization":"bearer #{log_in}"}
        headers = response.headers
        expect(headers["prev_page"]).to_not be_empty
      end

      it "response with correctly number record on page" do
        json = JSON.parse(response.body)
        headers = response.headers
        expect(json.length).to eq(Raction.page(headers["x-page"]).count)
      end

    end

    context "with valid token & admin & rcontroller_id invalid" do

      before :each do
        FactoryBot.create_list(:raction,30,create_attributes)
        get api_v1_rcontroller_ractions_path(1111), headers:admin_header, as: :json
      end

      it{	expect(response).to have_http_status(:not_found) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with valid token" do

      before :each do
        FactoryBot.create_list(:raction,30,create_attributes)
        get api_v1_rcontroller_ractions_path(@rcontroller), headers:user_header, as: :json
      end

      it{	expect(response).to have_http_status(:ok) }

      it "response with current page" do
        headers = response.headers
        expect(headers["x-page"]).to eq(1)
      end

      it "response with correctly number records" do
        headers = response.headers
        expect(headers["x-total"]).to eq(Raction.count)
      end

      it "response with number records per page" do
        headers = response.headers
        expect(headers["x-per-page"]).to eq(25)
      end

      it "response with next page" do
        headers = response.headers
        expect(headers["next_page"]).to_not be_empty
      end

      it "response with prev page" do
        get response.headers["next_page"], headers:{"Authorization":"bearer #{log_in}"}
        headers = response.headers
        expect(headers["prev_page"]).to_not be_empty
      end

      it "response with correctly number record on page" do
        json = JSON.parse(response.body)
        headers = response.headers
        expect(json.length).to eq(Raction.page(headers["x-page"]).count)
      end

    end

    context "with valid token & rcontroller_id invalid" do

      before :each do
        FactoryBot.create_list(:raction,30,create_attributes)
        get api_v1_rcontroller_ractions_path(1111), headers:user_header, as: :json
      end

      it{	expect(response).to have_http_status(:not_found) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with invalid token" do

      before :each do
        FactoryBot.create_list(:raction,30,create_attributes)
        get api_v1_rcontroller_ractions_path(@rcontroller), headers:invalid_header, as: :json
      end

      it{	expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with invalid token & rcontroller_id invalid" do

      before :each do
        FactoryBot.create_list(:raction,30,create_attributes)
        get api_v1_rcontroller_ractions_path(1111), headers:user_header, as: :json
      end

      it{	expect(response).to have_http_status(:not_found) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

  end

  describe "POST /api/v1/rcontrollers/:rcontroller_id/ractions" do

    context "with valid token & admin" do

      before :each do
        post api_v1_rcontroller_ractions_path(@rcontroller), headers:admin_header, params:{ raction: valid_attributes }, as: :json
      end

      it { expect(response).to have_http_status(:created) }

      it "create to rcontroller" do
        expect{
          post api_v1_rcontroller_ractions_path(@rcontroller), headers:admin_header, params:{ raction: valid_attributes }, as: :json
        }.to change(Raction,:count).by(1)
      end

    end

    context "with valid token & admin & rcontroller_id invalid" do

      before :each do
        post api_v1_rcontroller_ractions_path(1111), headers:admin_header, params:{ raction: valid_attributes }, as: :json
      end

      it { expect(response).to have_http_status(:not_found) }

      it "create to rcontroller" do
        expect{
          post api_v1_rcontroller_ractions_path(1111), headers:admin_header, params:{ raction: valid_attributes }, as: :json
        }.to change(Raction,:count).by(0)
      end

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with valid token" do

      before :each do
        post api_v1_rcontroller_ractions_path(@rcontroller), headers:user_header, params:{ raction: valid_attributes }, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "create to rcontroller" do
        expect{
          post api_v1_rcontroller_ractions_path(@rcontroller), headers:user_header, params:{ raction: valid_attributes }, as: :json
        }.to change(Raction,:count).by(0)
      end

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with valid token & rcontroller_id invalid" do

      before :each do
        post api_v1_rcontroller_ractions_path(1111), headers:user_header, params:{ raction: valid_attributes }, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "create to rcontroller" do
        expect{
          post api_v1_rcontroller_ractions_path(1111), headers:user_header, params:{ raction: valid_attributes }, as: :json
        }.to change(Raction,:count).by(0)
      end

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with invalid token" do

      before :each do
        post api_v1_rcontroller_ractions_path(@rcontroller), headers:invalid_header, params:{ raction: valid_attributes }, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "create to rcontroller" do
        expect{
          post api_v1_rcontroller_ractions_path(@rcontroller), headers:invalid_header, params:{ raction: valid_attributes }, as: :json
        }.to change(Raction,:count).by(0)
      end

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with invalid token & rcontroller_id invalid" do

      before :each do
        post api_v1_rcontroller_ractions_path(1111), headers:invalid_header, params:{ raction: valid_attributes }, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "create to rcontroller" do
        expect{
          post api_v1_rcontroller_ractions_path(1111), headers:invalid_header, params:{ raction: valid_attributes }, as: :json
        }.to change(Raction,:count).by(0)
      end

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

  end

  describe "GET /api/v1/rcontrollers/:rcontroller_id/ractions/:id" do

    context "with valid token & admin" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        get api_v1_rcontroller_raction_path(@rcontroller,@raction), headers: admin_header, as: :json
      end

      it { expect(response).to have_http_status(:ok) }

      it "response with category" do
        json = JSON.parse(response.body)
        expect(json["id"]).to eq(@raction.id)
      end

      it "Manda los atributos del menu" do
        json = JSON.parse(response.body)
        expect(json.keys).to contain_exactly("id","name","rcontroller","created_at","updated_at","url")
      end

    end

    context "with valid token & admin & rcontroller_id invalid & raction_id valid" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        get api_v1_rcontroller_raction_path(1111,@raction), headers: admin_header, as: :json
      end

      it { expect(response).to have_http_status(:not_found) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with valid token & admin & rcontroller_id valid & raction_id invalid" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        get api_v1_rcontroller_raction_path(@rcontroller,1111), headers: admin_header, as: :json
      end

      it { expect(response).to have_http_status(:not_found) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with valid token " do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        get api_v1_rcontroller_raction_path(@rcontroller,@raction), headers: user_header, as: :json
      end

      it { expect(response).to have_http_status(:ok) }

      it "response with category" do
        json = JSON.parse(response.body)
        expect(json["id"]).to eq(@raction.id)
      end

      it "Manda los atributos del menu" do
        json = JSON.parse(response.body)
        expect(json.keys).to contain_exactly("id","name","rcontroller","created_at","updated_at","url")
      end

    end

    context "with valid token & rcontroller_id invalid & raction_id valid" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        get api_v1_rcontroller_raction_path(1111,@raction), headers: user_header, as: :json
      end

      it { expect(response).to have_http_status(:not_found) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with valid token & rcontroller_id valid & raction_id invalid" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        get api_v1_rcontroller_raction_path(@rcontroller,1111), headers: user_header, as: :json
      end

      it { expect(response).to have_http_status(:not_found) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with invalid token " do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        get api_v1_rcontroller_raction_path(@rcontroller,@raction), headers: invalid_header, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with invalid token & rcontroller_id invalid & raction_id valid" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        get api_v1_rcontroller_raction_path(1111,@raction), headers: invalid_header, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with invalid token & rcontroller_id valid & raction_id invalid" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        get api_v1_rcontroller_raction_path(@rcontroller,1111), headers: invalid_header, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

  end

  describe "PATCH /api/v1/rcontrollers/:rcontroller_id/ractions/:id" do

    context "with valid token & admin" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        patch api_v1_rcontroller_raction_path(@rcontroller,@raction), headers: admin_header, params: update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:ok) }

      it "update category" do
				json = JSON.parse(response.body)
				expect(json["name"]).to eq("new_name")
			end

    end

    context "with valid token & admin & rcontroller_id invalid & raction_id valid" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        patch api_v1_rcontroller_raction_path(1111,@raction), headers: admin_header, params: update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:not_found) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with valid token & admin & rcontroller_id valid & raction_id invalid" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        patch api_v1_rcontroller_raction_path(@rcontroller,1111), headers: admin_header, params: update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:not_found) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with valid token" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        patch api_v1_rcontroller_raction_path(@rcontroller,@raction), headers: user_header, params: update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with valid token & rcontroller_id invalid & raction_id valid" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        patch api_v1_rcontroller_raction_path(1111,@raction), headers: user_header, params: update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with valid token & rcontroller_id valid & raction_id invalid" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        patch api_v1_rcontroller_raction_path(@rcontroller,1111), headers: user_header, params: update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:not_found) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with invalid token" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        patch api_v1_rcontroller_raction_path(@rcontroller,@raction), headers: invalid_header, params: update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with invalid token & rcontroller_id invalid & raction_id valid" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        patch api_v1_rcontroller_raction_path(1111,@raction), headers: invalid_header, params: update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with invalid token & rcontroller_id valid & raction_id invalid" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        patch api_v1_rcontroller_raction_path(@rcontroller,1111), headers: invalid_header, params: update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

  end

  describe "PUT /api/v1/rcontrollers/:rcontroller_id/ractions/:id" do

    context "with valid token & admin" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        put api_v1_rcontroller_raction_path(@rcontroller,@raction), headers: admin_header, params: update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:ok) }

      it "update category" do
				json = JSON.parse(response.body)
				expect(json["name"]).to eq("new_name")
			end

    end

    context "with valid token & admin & rcontroller_id invalid & raction_id valid" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        put api_v1_rcontroller_raction_path(1111,@raction), headers: admin_header, params: update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:not_found) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with valid token & admin & rcontroller_id valid & raction_id invalid" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        put api_v1_rcontroller_raction_path(@rcontroller,1111), headers: admin_header, params: update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:not_found) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with valid token" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        put api_v1_rcontroller_raction_path(@rcontroller,@raction), headers: user_header, params: update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with valid token & rcontroller_id invalid & raction_id valid" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        put api_v1_rcontroller_raction_path(1111,@raction), headers: user_header, params: update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with valid token & rcontroller_id valid & raction_id invalid" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        put api_v1_rcontroller_raction_path(@rcontroller,1111), headers: user_header, params: update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:not_found) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with invalid token" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        put api_v1_rcontroller_raction_path(@rcontroller,@raction), headers: invalid_header, params: update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with invalid token & rcontroller_id invalid & raction_id valid" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        put api_v1_rcontroller_raction_path(1111,@raction), headers: invalid_header, params: update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with invalid token & rcontroller_id valid & raction_id invalid" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
        put api_v1_rcontroller_raction_path(@rcontroller,1111), headers: invalid_header, params: update_attributes, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

  end

  describe "DELETE /api/v1/rcontrollers/:rcontroller_id/ractions/:id" do

    context "with valid token & admin" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
      end

      it {
        delete api_v1_rcontroller_raction_path(@rcontroller,@raction), headers:admin_header, as: :json
        expect(response).to have_http_status(:no_content)
      }

      it "Delete Post" do
        expect{
          delete api_v1_rcontroller_raction_path(@rcontroller,@raction), headers:admin_header, as: :json
        }.to change(Raction,:count).by(-1)
      end

    end

    context "with valid token & admin & rcontroller_id invalid & raction_id valid" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
      end

      it {
        delete api_v1_rcontroller_raction_path(1111,@raction), headers:admin_header, as: :json
        expect(response).to have_http_status(:not_found)
      }

      it "Delete Post" do
        expect{
          delete api_v1_rcontroller_raction_path(1111,@raction), headers:admin_header, as: :json
        }.to change(Raction,:count).by(0)
      end

    end

    context "with valid token & admin & rcontroller_id valid & raction_id invalid" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
      end

      it {
        delete api_v1_rcontroller_raction_path(@rcontroller,1111), headers:admin_header, as: :json
        expect(response).to have_http_status(:not_found)
      }

      it "Delete Post" do
        expect{
          delete api_v1_rcontroller_raction_path(@rcontroller,1111), headers:admin_header, as: :json
        }.to change(Raction,:count).by(0)
      end

    end

    context "with valid token" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
      end

      it {
        delete api_v1_rcontroller_raction_path(@rcontroller,@raction), headers:user_header, as: :json
        expect(response).to have_http_status(:unauthorized)
      }

      it "Delete Post" do
        expect{
          delete api_v1_rcontroller_raction_path(@rcontroller,@raction), headers:user_header, as: :json
        }.to change(Raction,:count).by(0)
      end

    end

    context "with valid token & rcontroller_id invalid & raction_id valid" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
      end

      it {
        delete api_v1_rcontroller_raction_path(1111,@raction), headers:user_header, as: :json
        expect(response).to have_http_status(:unauthorized)
      }

      it "Delete Post" do
        expect{
          delete api_v1_rcontroller_raction_path(1111,@raction), headers:user_header, as: :json
        }.to change(Raction,:count).by(0)
      end

    end

    context "with valid token & rcontroller_id valid & raction_id invalid" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
      end

      it {
        delete api_v1_rcontroller_raction_path(@rcontroller,1111), headers:user_header, as: :json
        expect(response).to have_http_status(:not_found)
      }

      it "Delete Post" do
        expect{
          delete api_v1_rcontroller_raction_path(@rcontroller,111), headers:user_header, as: :json
        }.to change(Raction,:count).by(0)
      end

    end

    context "with invalid token" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
      end

      it {
        delete api_v1_rcontroller_raction_path(@rcontroller,@raction), headers:invalid_header, as: :json
        expect(response).to have_http_status(:unauthorized)
      }

      it "Delete Post" do
        expect{
          delete api_v1_rcontroller_raction_path(@rcontroller,@raction), headers:user_header, as: :json
        }.to change(Raction,:count).by(0)
      end

    end

    context "with valid token & rcontroller_id invalid & raction_id valid" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
      end

      it {
        delete api_v1_rcontroller_raction_path(1111,@raction), headers:invalid_header, as: :json
        expect(response).to have_http_status(:unauthorized)
      }

      it "Delete Post" do
        expect{
          delete api_v1_rcontroller_raction_path(1111,@raction), headers:user_header, as: :json
        }.to change(Raction,:count).by(0)
      end

    end

    context "with valid token & rcontroller_id valid & raction_id invalid" do

      before :each do
        @raction = FactoryBot.create(:raction,create_attributes)
      end

      it {
        delete api_v1_rcontroller_raction_path(@rcontroller,1111), headers:invalid_header, as: :json
        expect(response).to have_http_status(:unauthorized)
      }

      it "Delete Post" do
        expect{
          delete api_v1_rcontroller_raction_path(@rcontroller,111), headers:invalid_header, as: :json
        }.to change(Raction,:count).by(0)
      end

    end

  end

end
