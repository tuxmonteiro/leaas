require 'test_helper'
require 'securerandom'

class OwnersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @owner = owners(:one)
  end

  def owners_url
    '/owners'
  end

  def owner_url(owner)
    "/owners/#{owner.id}"
  end

  test 'should get index' do
    get owners_url
    assert_response :success
  end

  test 'should create owner' do
    assert_difference('Owner.count') do
      post owners_url, params: { owner: { acme_id: @owner.acme_id, detail: @owner.detail, email: SecureRandom.uuid, name: SecureRandom.uuid, pkcs12: @owner.pkcs12 } }
    end

    assert_response 201
  end

  test 'should show owner' do
    get owner_url(@owner)
    assert_response :success
  end

  test 'should update owner' do
    patch owner_url(@owner), params: { owner: { acme_id: @owner.acme_id, detail: @owner.detail, email: @owner.email, name: @owner.name, pkcs12: @owner.pkcs12 } }
    assert_response 200
  end

  test 'should destroy owner' do
    assert_difference('Owner.count', -1) do
      delete owner_url(@owner)
    end

    assert_response 204
  end
end
