require 'test_helper'
require 'securerandom'

class CertificatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @certificate = certificates(:one)
  end

  test 'should get index' do
    get owner_certificates_url(:owner_id =>@certificate.owner.id, :id => @certificate)
    assert_response :success
  end

  test 'should create certificate' do
    assert_difference('Certificate.count') do
      post owner_certificates_url(:owner_id =>@certificate.owner.id, :id => @certificate), params: { certificate: { acme_id: @certificate.acme_id, cn: SecureRandom.uuid, csr: @certificate.csr, detail: @certificate.detail, key: @certificate.key, last_crt: @certificate.last_crt, owner_id: @certificate.owner_id } }
    end

    assert_response 201
  end

  test 'should show certificate' do
    get owner_certificate_url(@certificate)
    assert_response :success
  end

  test 'should update certificate' do
    patch owner_certificate_url(@certificate), params: { certificate: { acme_id: @certificate.acme_id, cn: @certificate.cn, csr: @certificate.csr, detail: @certificate.detail, key: @certificate.key, last_crt: @certificate.last_crt, owner_id: @certificate.owner_id } }
    assert_response 200
  end

  test 'should destroy certificate' do
    assert_difference('Certificate.count', -1) do
      delete owner_certificate_url(@certificate)
    end

    assert_response 204
  end
end
