require 'test_helper'
require 'securerandom'

class CertificatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @certificate = certificates(:one)
  end

  def certificates_url(owner_id)
    "/owners/#{owner_id}/certificates"
  end

  def certificate_url(certificate, owner_id)
    "/owners/#{owner_id}/certificates/#{certificate.id}"
  end

  test 'should get index' do
    get certificates_url(@certificate.owner_id)
    assert_response :success
  end

  test 'should create certificate' do
    assert_difference('Certificate.count') do
      post certificates_url(@certificate.owner_id), params: { certificate: { acme_id: @certificate.acme_id, cn: SecureRandom.uuid, csr: @certificate.csr, detail: @certificate.detail, key: @certificate.key, last_crt: @certificate.last_crt, owner_id: @certificate.owner_id } }
    end

    assert_response 201
  end

  test 'should show certificate' do
    get certificate_url(@certificate, @certificate.owner_id)
    assert_response :success
  end

  test 'should update certificate' do
    patch certificate_url(@certificate, @certificate.owner_id), params: { certificate: { acme_id: @certificate.acme_id, cn: @certificate.cn, csr: @certificate.csr, detail: @certificate.detail, key: @certificate.key, last_crt: @certificate.last_crt, owner_id: @certificate.owner_id } }
    assert_response 200
  end

  test 'should destroy certificate' do
    assert_difference('Certificate.count', -1) do
      delete certificate_url(@certificate, @certificate.owner_id)
    end

    assert_response 204
  end
end
