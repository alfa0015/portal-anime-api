require 'rails_helper'

RSpec.describe "Rcontrollers", type: :request do

  describe "GET /api/v1/rcontrollers" do

    context "with valid token" do

      before :each do
        FactoryBot.create_list(:rcontroller,30)
        get api_v1_rcontrollers_path, headers:{"Authorization":"bearer #{log_in}"}, as: :json
      end

      it{	expect(response).to have_http_status(:ok) }

      it "response with current page" do
        headers = response.headers
        expect(headers["x-page"]).to eq(1)
      end

      it "response with correctly number records" do
        headers = response.headers
        expect(headers["x-total"]).to eq(Rcontroller.count)
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
        expect(json.length).to eq(Rcontroller.page(headers["x-page"]).count)
      end

    end

    context "with invalid token" do

      before :each do
        FactoryBot.create_list(:rcontroller,30)
        get api_v1_rcontrollers_path, headers:{"Authorization":"bearer"}, as: :json
      end

      it{	expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

  end

  describe "POST /api/v1/rcontrollers" do

    context "POST /api/v1/rcontrollers" do

      context "with token valid & is admin" do

        before :each do
          @rcontroller = FactoryBot.build(:rcontroller)
          post api_v1_rcontrollers_path, headers:{"Authorization":"bearer #{log_in_admin}"}, params:{ rcontroller:@rcontroller }, as: :json
        end

        it { expect(response).to have_http_status(:created) }

        it "create to rcontroller" do
  				expect{
  					post api_v1_rcontrollers_path, headers:{"Authorization":"bearer #{log_in_admin}"}, params:{ rcontroller:@rcontroller }, as: :json
  				}.to change(Rcontroller,:count).by(1)
  			end

      end

      context "with token valid" do

        before :each do
          @rcontroller = FactoryBot.build(:rcontroller)
          post api_v1_rcontrollers_path, headers:{"Authorization":"bearer #{log_in}"}, params:{ rcontroller:@rcontroller }, as: :json
        end

        it { expect(response).to have_http_status(:unauthorized) }

        it "create to rcontroller" do
  				expect{
  					post api_v1_rcontrollers_path, headers:{"Authorization":"bearer #{log_in}"}, params:{ rcontroller:@rcontroller }, as: :json
  				}.to change(Rcontroller,:count).by(0)
  			end

        it "responds with error" do
          json = JSON.parse(response.body)
          expect(json["errors"]).to_not be_empty
        end

      end

      context "with token invalid" do

        before :each do
          @rcontroller = FactoryBot.build(:rcontroller)
          post api_v1_rcontrollers_path, headers:{"Authorization":"bearer"}, params:{ rcontroller:@rcontroller }, as: :json
        end

        it { expect(response).to have_http_status(:unauthorized) }

        it "create to rcontroller" do
  				expect{
  					post api_v1_rcontrollers_path, headers:{"Authorization":"bearer"}, params:{ rcontroller:@rcontroller }, as: :json
  				}.to change(Rcontroller,:count).by(0)
  			end

        it "responds with error" do
          json = JSON.parse(response.body)
          expect(json["errors"]).to_not be_empty
        end

      end

    end

  end

  describe "GET /api/v1/rcontrollers/:id" do

    context "with token valid & admin" do

      before :each do
        @rcontroller = FactoryBot.create(:rcontroller)
        get api_v1_rcontroller_path(@rcontroller), headers:{"Authorization":"bearer #{log_in_admin}","Content-Type":"application/json"}, as: :json
      end

      it { expect(response).to have_http_status(:ok) }

      it "response with rcontroller" do
        json = JSON.parse(response.body)
        expect(json["id"]).to eq(@rcontroller.id)
      end

      it "response with correctly attributes" do
        json = JSON.parse(response.body)
        expect(json.keys).to contain_exactly("id","name","actions","created_at","updated_at","url")
      end

    end

    context "with token valid " do

      before :each do
        @rcontroller = FactoryBot.create(:rcontroller)
        get api_v1_rcontroller_path(@rcontroller), headers:{"Authorization":"bearer #{log_in}","Content-Type":"application/json"}, as: :json
      end

      it { expect(response).to have_http_status(:ok) }

      it "response with rcontroller" do
        json = JSON.parse(response.body)
        expect(json["id"]).to eq(@rcontroller.id)
      end

      it "response with correctly attributes" do
        json = JSON.parse(response.body)
        expect(json.keys).to contain_exactly("id","name","actions","created_at","updated_at","url")
      end

    end

    context "with token valid & id not valid" do

      before :each do
        @rcontroller = FactoryBot.create(:rcontroller)
        get api_v1_rcontroller_path(1111), headers:{"Authorization":"bearer #{log_in}","Content-Type":"application/json"}, as: :json
      end

      it { expect(response).to have_http_status(:not_found) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

  end

  describe "PATCH /api/v1/rcontrollers/:id" do

    context "with token valid & admin" do

      before :each do
        @rcontroller = FactoryBot.create(:rcontroller)
        patch api_v1_rcontroller_path(@rcontroller), headers:{"Authorization":"bearer #{log_in_admin}"}, params:{ rcontroller: {name:"new_name"} }, as: :json
      end

      it { expect(response).to have_http_status(:ok) }

      it "response with new data" do
				json = JSON.parse(response.body)
				expect(json["name"]).to eq("new_name")
			end

    end

    context "with token valid & admin & id invalid" do

      before :each do
        @rcontroller = FactoryBot.create(:rcontroller)
        patch api_v1_rcontroller_path(1111), headers:{"Authorization":"bearer #{log_in_admin}"}, params:{ rcontroller: {name:"new_name"} }, as: :json
      end

      it { expect(response).to have_http_status(:not_found) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with token valid" do

      before :each do
        @rcontroller = FactoryBot.create(:rcontroller)
        patch api_v1_rcontroller_path(@rcontroller), headers:{"Authorization":"bearer #{log_in}"}, params:{ rcontroller: {name:"new_name"} }, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with token valid & id invalid" do

      before :each do
        @rcontroller = FactoryBot.create(:rcontroller)
        patch api_v1_rcontroller_path(1111), headers:{"Authorization":"bearer #{log_in_admin}"}, params:{ rcontroller: {name:"new_name"} }, as: :json
      end

      it { expect(response).to have_http_status(:not_found) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with token invalid" do

      before :each do
        @rcontroller = FactoryBot.create(:rcontroller)
        patch api_v1_rcontroller_path(@rcontroller), headers:{"Authorization":"bearer"}, params:{ rcontroller: {name:"new_name"} }, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with token invalid & id invalid" do

      before :each do
        @rcontroller = FactoryBot.create(:rcontroller)
        patch api_v1_rcontroller_path(1111), headers:{"Authorization":"bearer"}, params:{ rcontroller: {name:"new_name"} }, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

  end

  describe "PUT /api/v1/rcontrollers/:id" do

    context "with token valid & admin" do

      before :each do
        @rcontroller = FactoryBot.create(:rcontroller)
        put api_v1_rcontroller_path(@rcontroller), headers:{"Authorization":"bearer #{log_in_admin}"}, params:{ rcontroller: {name:"new_name"} }, as: :json
      end

      it { expect(response).to have_http_status(:ok) }

      it "response with new data" do
				json = JSON.parse(response.body)
				expect(json["name"]).to eq("new_name")
			end

    end

    context "with token valid & admin & id invalid" do

      before :each do
        @rcontroller = FactoryBot.create(:rcontroller)
        put api_v1_rcontroller_path(1111), headers:{"Authorization":"bearer #{log_in_admin}"}, params:{ rcontroller: {name:"new_name"} }, as: :json
      end

      it { expect(response).to have_http_status(:not_found) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with token valid" do

      before :each do
        @rcontroller = FactoryBot.create(:rcontroller)
        put api_v1_rcontroller_path(@rcontroller), headers:{"Authorization":"bearer #{log_in}"}, params:{ rcontroller: {name:"new_name"} }, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with token valid & id invalid" do

      before :each do
        @rcontroller = FactoryBot.create(:rcontroller)
        put api_v1_rcontroller_path(1111), headers:{"Authorization":"bearer #{log_in_admin}"}, params:{ rcontroller: {name:"new_name"} }, as: :json
      end

      it { expect(response).to have_http_status(:not_found) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with token invalid" do

      before :each do
        @rcontroller = FactoryBot.create(:rcontroller)
        put api_v1_rcontroller_path(@rcontroller), headers:{"Authorization":"bearer"}, params:{ rcontroller: {name:"new_name"} }, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    context "with token invalid & id invalid" do

      before :each do
        @rcontroller = FactoryBot.create(:rcontroller)
        put api_v1_rcontroller_path(1111), headers:{"Authorization":"bearer"}, params:{ rcontroller: {name:"new_name"} }, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

  end

  describe "DELETE api/v1/rcontrollers/:id" do

    context "with token valid & admin" do

      before :each do
        @rcontroller = FactoryBot.create(:rcontroller)
      end

      it {
        delete api_v1_rcontroller_path(@rcontroller), headers:{"Authorization":"bearer #{log_in_admin}"}, as: :json
        expect(response).to have_http_status(:no_content)
      }

      it "Delete Post" do
        expect{
          delete api_v1_rcontroller_path(@rcontroller), headers:{"Authorization":"bearer #{log_in_admin}"}, as: :json
        }.to change(Rcontroller,:count).by(-1)
      end

    end

    context "with token valid & admin & id invalid" do

      before :each do
        @rcontroller = FactoryBot.create(:rcontroller)
      end

      it {
        delete api_v1_rcontroller_path(1111), headers:{"Authorization":"bearer #{log_in_admin}"}, as: :json
        expect(response).to have_http_status(:not_found)
      }

      it "Delete Post" do
        expect{
          delete api_v1_rcontroller_path(1111), headers:{"Authorization":"bearer #{log_in_admin}"}, as: :json
        }.to change(Rcontroller,:count).by(0)
      end

    end

    context "with token valid" do

      before :each do
        @rcontroller = FactoryBot.create(:rcontroller)
      end

      it {
        delete api_v1_rcontroller_path(@rcontroller), headers:{"Authorization":"bearer #{log_in}"}, as: :json
        expect(response).to have_http_status(:unauthorized)
      }

      it "Delete Post" do
        expect{
          delete api_v1_rcontroller_path(@rcontroller), headers:{"Authorization":"bearer #{log_in}"}, as: :json
        }.to change(Rcontroller,:count).by(0)
      end


    end

    context "with token valid & id invalid" do

      before :each do
        @rcontroller = FactoryBot.create(:rcontroller)
      end

      it {
        delete api_v1_rcontroller_path(1111), headers:{"Authorization":"bearer #{log_in_admin}"}, as: :json
        expect(response).to have_http_status(:not_found)
      }

      it "Delete Post" do
        expect{
          delete api_v1_rcontroller_path(1111), headers:{"Authorization":"bearer #{log_in_admin}"}, as: :json
        }.to change(Rcontroller,:count).by(0)
      end

    end

    context "with token invalid" do

      before :each do
        @rcontroller = FactoryBot.create(:rcontroller)
      end

      it {
        delete api_v1_rcontroller_path(@rcontroller), headers:{"Authorization":"bearer"}, as: :json
        expect(response).to have_http_status(:unauthorized)
      }

      it "Delete Post" do
        expect{
          delete api_v1_rcontroller_path(@rcontroller), headers:{"Authorization":"bearer"}, as: :json
        }.to change(Rcontroller,:count).by(0)
      end


    end

    context "with token invalid & id invalid" do

      before :each do
        @rcontroller = FactoryBot.create(:rcontroller)
      end

      it {
        delete api_v1_rcontroller_path(1111), headers:{"Authorization":"bearer"}, as: :json
        expect(response).to have_http_status(:unauthorized)
      }

      it "Delete Post" do
        expect{
          delete api_v1_rcontroller_path(1111), headers:{"Authorization":"bearer"}, as: :json
        }.to change(Rcontroller,:count).by(0)
      end

    end

  end

end
