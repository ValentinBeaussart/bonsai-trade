require "test_helper"

class AdsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ad = ads(:one)
  end

  test "should get index" do
    get ads_url, as: :json
    assert_response :success
  end

  test "should create ad" do
    assert_difference("Ad.count") do
      post ads_url, params: { ad: { category_id: @ad.category_id, description: @ad.description, latin_name: @ad.latin_name, name: @ad.name, place: @ad.place, price: @ad.price, user_id: @ad.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show ad" do
    get ad_url(@ad), as: :json
    assert_response :success
  end

  test "should update ad" do
    patch ad_url(@ad), params: { ad: { category_id: @ad.category_id, description: @ad.description, latin_name: @ad.latin_name, name: @ad.name, place: @ad.place, price: @ad.price, user_id: @ad.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy ad" do
    assert_difference("Ad.count", -1) do
      delete ad_url(@ad), as: :json
    end

    assert_response :no_content
  end
end
