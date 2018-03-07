require 'rails_helper'
describe Api::V1::PostsController, type: :request do

  context "With token valid" do

    describe "GET /api/v1/posts(.:format)" do

      before :each do
        FactoryBot.create_list(:post,10)
        get api_v1_posts_path, headers:{"Authorization":"bearer #{log_in}","Content-Type":"application/json"}, as: :json
      end

      it{	expect(response).to have_http_status(:ok) }

      it "mande la lista de menus" do
        json = JSON.parse(response.body)
        expect(json.length).to eq(Post.count)
      end

    end

    describe "GET /api/v1/posts/:id(.:format)" do

      before :each do
        @post = FactoryBot.create(:post)
        get api_v1_post_path(@post.id), headers:{"Authorization":"bearer #{log_in}","Content-Type":"application/json"}, as: :json
      end

      it { expect(response).to have_http_status(:ok) }

      it "show post request" do
        json = JSON.parse(response.body)
        expect(json["id"]).to eq(@post.id)
      end

      it "Manda los atributos del menu" do
        json = JSON.parse(response.body)
        expect(json.keys).to contain_exactly("id","title","body","created_at","updated_at","user_email","url")
      end

    end

    describe "POST /api/v1/posts" do

      before :each do
        @post = FactoryBot.build(:post)
        post api_v1_posts_path, headers:{"Authorization":"bearer #{log_in}","Content-Type":"application/json"}, params:{ post:@post }, as: :json
      end

      it { expect(response).to have_http_status(:created) }

      it "Crea un post" do
				expect{
					post api_v1_posts_path, headers:{"Authorization":"bearer #{log_in}","Content-Type":"application/json"}, params:{ post:@post }, as: :json
				}.to change(Post,:count).by(1)
			end

    end

    describe "PATCH /api/v1/posts/:id" do

      before :each do
        @post = FactoryBot.create(:post)
        patch api_v1_post_path(@post.id), headers:{"Authorization":"bearer #{log_in}","Content-Type":"application/json"}, params:{ post:{ title:"new_title",body:"new_body"} }, as: :json
      end

      it { expect(response).to have_http_status(:ok) }

      it "update post" do
				json = JSON.parse(response.body)
				expect(json["title"]).to eq("new_title")
			end

    end

    describe "PUT /api/v1/posts/:id" do

      before :each do
        @post = FactoryBot.create(:post)
        put api_v1_post_path(@post.id), headers:{"Authorization":"bearer #{log_in}","Content-Type":"application/json"}, params:{ post:{ title:"new_title",body:"new_body"} }, as: :json
      end

      it { expect(response).to have_http_status(:ok) }

      it "update post" do
				json = JSON.parse(response.body)
				expect(json["title"]).to eq("new_title")
			end

    end

    describe "DELETE /api/v1/posts/:id" do

      before :each do
        @post = FactoryBot.create(:post)
      end

      it {
				delete api_v1_post_path(@post.id), headers:{"Authorization":"bearer #{log_in}","Content-Type":"application/json"}, as: :json
				expect(response).to have_http_status(:no_content)
			}

      it "Delete Post" do
				expect{
					delete api_v1_post_path(@post.id), headers:{"Authorization":"bearer #{log_in}","Content-Type":"application/json"}, as: :json
        }.to change(Post,:count).by(-1)
			end

    end

  end

  context "With token invalid" do

    describe "GET /api/v1/posts(.:format)" do

      before :each do
        FactoryBot.create_list(:post,10)
        get api_v1_posts_path, as: :json
      end

      it{	expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    describe "GET /api/v1/posts/:id(.:format)" do

      before :each do
        @post = FactoryBot.create(:post)
        get api_v1_post_path(@post.id), as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    describe "POST /api/v1/posts" do

      before :each do
        @post = FactoryBot.build(:post)
        post api_v1_posts_path, params:{ post:@post }, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "Not create post" do
				expect{
					post api_v1_posts_path, params:{ post:@post }, as: :json
        }.to change(Post,:count).by(0)
			end

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    describe "PATCH /api/v1/posts/:id" do

      before :each do
        @post = FactoryBot.create(:post)
        patch api_v1_post_path(@post.id), params:{ post:{ title:"new_title",body:"new_body"} }, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    describe "PUT /api/v1/posts/:id" do

      before :each do
        @post = FactoryBot.create(:post)
        put api_v1_post_path(@post.id), params:{ post:{ title:"new_title",body:"new_body"} }, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it "responds with error" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end

    end

    describe "DELETE /api/v1/posts/:id" do

      before :each do
        @post = FactoryBot.create(:post)
      end

      it {
				delete api_v1_post_path(@post.id), as: :json
				expect(response).to have_http_status(:unauthorized)
			}

      it "Delete Post" do
				expect{
					delete api_v1_post_path(@post.id), as: :json
        }.to change(Post,:count).by(0)
			end

      it "responds with error" do
				delete api_v1_post_path(@post.id), as: :json
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
			end

    end

  end


end
