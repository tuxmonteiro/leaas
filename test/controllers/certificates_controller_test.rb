require 'test_helper'

class CertificatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @certificate = certificates(:one)
  end

  test "should get index" do
    get certificates_url, as: :json
    assert_response :success
  end

  test "should create certificate" do
    assert_difference('Certificate.count') do
      post certificates_url, params: { certificate: { acme_id: @certificate.acme_id, cn: @certificate.cn, csr: @certificate.csr, detail: @certificate.detail, key: @certificate.key, last_crt: @certificate.last_crt, owner_id: @certificate.owner_id } }, as: :json
    end

    assert_response 201
  end

  test "should show certificate" do
    get certificate_url(@certificate), as: :json
    assert_response :success
  end

  test "should update certificate" do
    patch certificate_url(@certificate), params: { certificate: { acme_id: @certificate.acme_id, cn: @certificate.cn, csr: @certificate.csr, detail: @certificate.detail, key: @certificate.key, last_crt: @certificate.last_crt, owner_id: @certificate.owner_id } }, as: :json
    assert_response 200
  end

  test "should destroy certificate" do
    assert_difference('Certificate.count', -1) do
      delete certificate_url(@certificate), as: :json
    end

    assert_response 204
  end
end
