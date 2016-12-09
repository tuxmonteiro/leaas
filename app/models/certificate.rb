require 'validators/csr_validator'

class Certificate < ApplicationRecord
  #attr_accessor :certificate, :private_key, :signing_request, :detail, :acme_id
  validates :signing_request, presence: true, csr: true



end
