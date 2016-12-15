require 'acme-client'
require 'openssl'
require 'singleton'

class LocalAcme
  include Singleton

  def initialize
    @acme_endpoint = APP_CONFIG['acme_endpoint']
    @gdns_endpoint = APP_CONFIG['gdns_endpoint']
    @gdns_token = APP_CONFIG['gdns_token']
    private_key = OpenSSL::PKey::RSA.new(4096)
    @client = Acme::Client.new(private_key: private_key, endpoint: @acme_endpoint, connection_options: { request: { open_timeout: 5, timeout: 5 } })
  end

  def register_owner(owner)
    registration = nil
    begin
      registration = @client.register(contact: "mailto:#{owner.email}")
    # rescue URI::BadURIError
    rescue => detail
      puts @acme_endpoint
      print detail.backtrace.join("\n")
    # puts "#{self} URI::BadURIError"
    end
    # registration.agree_terms unless registration.nil?
  end

  def request_cert(certificate)
    authorization = nil

    begin
      authorization = @client.authorize(domain: certificate.cn)
    rescue URI::BadURIError
      puts "#{self} URI::BadURIError"
    end
    unless authorization.nil?
      challenge = authorization.dns01
      token = challenge.token
      add_dns_txt(certificate.cn, token)

      # Once you are ready to serve the confirmation request you can proceed.
      #challenge.request_verification

      csr = Acme::Client::CertificateRequest.new(names: %W[ #{certificate.cn} ])
      crt = @client.new_certificate(csr)
      certificate.last_crt = crt.to_pem
    end
  end

  def add_dns_txt(domain, token)
    # globodns
  end

end