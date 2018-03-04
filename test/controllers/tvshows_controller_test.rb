require 'test_helper'

class TvshowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tvshow = tvshows(:one)
  end

  test "should get index" do
    get tvshows_url, as: :json
    assert_response :success
  end

  test "should create tvshow" do
    assert_difference('Tvshow.count') do
      post tvshows_url, params: { tvshow: { name: @tvshow.name } }, as: :json
    end

    assert_response 201
  end

  test "should show tvshow" do
    get tvshow_url(@tvshow), as: :json
    assert_response :success
  end

  test "should update tvshow" do
    patch tvshow_url(@tvshow), params: { tvshow: { name: @tvshow.name } }, as: :json
    assert_response 200
  end

  test "should destroy tvshow" do
    assert_difference('Tvshow.count', -1) do
      delete tvshow_url(@tvshow), as: :json
    end

    assert_response 204
  end
end
