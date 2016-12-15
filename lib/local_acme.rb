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
    begin
      contact = "mailto:#{owner.email}".freeze
      registration = @client.register(contact: contact)
      registration.agree_terms unless registration.nil?
    rescue => detail
      puts "#{detail.class}: #{detail.message}"
      print detail.backtrace.join("\n")
    end
  end

  def request_cert(certificate)
    begin
      authorization = @client.authorize(domain: certificate.cn)
      challenge = authorization.dns01
      token = challenge.token
      puts "TOKEN: #{token}"
      add_dns_txt(certificate.cn, token)
      challenge.request_verification

      csr = Acme::Client::CertificateRequest.new(names: %W[ #{certificate.cn} ])
      crt = @client.new_certificate(csr)
      certificate.last_crt = crt.to_pem
    rescue => detail
      puts "#{detail.class}: #{detail.message}"
      print detail.backtrace.join("\n")
    end
  end

  def add_dns_txt(domain, token)
    # globodns
  end

end