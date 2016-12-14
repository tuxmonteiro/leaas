require 'test_helper'

class OwnersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @owner = owners(:one)
  end

  test "should get index" do
    get owners_url, as: :json
    assert_response :success
  end

  test "should create owner" do
    assert_difference('Owner.count') do
      post owners_url, params: { owner: { acme_id: @owner.acme_id, detail: @owner.detail, email: @owner.email, name: @owner.name, pkcs12: @owner.pkcs12 } }, as: :json
    end

    assert_response 201
  end

  test "should show owner" do
    get owner_url(@owner), as: :json
    assert_response :success
  end

  test "should update owner" do
    patch owner_url(@owner), params: { owner: { acme_id: @owner.acme_id, detail: @owner.detail, email: @owner.email, name: @owner.name, pkcs12: @owner.pkcs12 } }, as: :json
    assert_response 200
  end

  test "should destroy owner" do
    assert_difference('Owner.count', -1) do
      delete owner_url(@owner), as: :json
    end

    assert_response 204
  end
end
