require 'acme-client'

module AcmeClient

  $acme_endpoint = APP_CONFIG['acme_endpoint']

  def register_owner(owner)
    client = Acme::Client.new(private_key: nil, endpoint: $acme_endpoint, connection_options: { request: { open_timeout: 5, timeout: 5 }})
    puts $acme_endpoint
  end

  def register_certificate(certificate)
    acme_endpoint = APP_CONFIG['acme_endpoint']
  end

end