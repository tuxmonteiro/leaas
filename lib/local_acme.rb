require 'acme-client'
require 'singleton'
require 'openssl'

class LocalAcme
  include Singleton

  def initialize
    @acme_endpoint = APP_CONFIG['acme_endpoint']
    @gdns_endpoint = APP_CONFIG['gdns_endpoint']
    @gdns_token = APP_CONFIG['gdns_token']
  end

  def register_owner(owner)
    client = _new_client(owner)
    _register_client(client, owner, true) unless client.nil?
  end

  def request_cert(certificate)
    begin
      client = _new_client(certificate.owner)
      raise StandardError if client.nil?
      authorization = client.authorize(domain: certificate.cn)
      challenge = authorization.dns01
      token = challenge.token
      puts "TOKEN: #{token}"
      add_dns_txt(certificate.cn, token)
      challenge.request_verification

      csr = Acme::Client::CertificateRequest.new(names: %W[ #{certificate.cn} ])
      crt = client.new_certificate(csr)
      certificate.last_crt = crt.to_pem
    rescue => detail
      puts "#{detail.class}: #{detail.message}"
      print detail.backtrace.join("\n")
    end
  end

  private
  def _new_client(owner)
    begin
      private_key = OpenSSL::PKey::RSA.new(owner.private_pem)
      client = Acme::Client.new(private_key: private_key,
                                endpoint: @acme_endpoint,
                                connection_options: {request: {open_timeout: 5, timeout: 5}})
      return client
    rescue Exception
      return nil
    end
  end

  def _register_client(client, owner, agree=false)
    registration = nil
    begin
      contact = "mailto:#{owner.email}".freeze
      registration = client.register(contact: contact)
    rescue => detail
      puts "#{detail.class}: #{detail.message}"
      print detail.backtrace.join("\n")
    end
    registration.agree_terms if agree and !registration.nil?
  end

  def add_dns_txt(domain, token)
    # globodns
  end

end