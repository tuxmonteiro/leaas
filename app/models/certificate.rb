require 'local_acme'

class Certificate < ApplicationRecord
  #attr_accessor :cn, :last_crt, :csr, :key, :detail, :acme_id, :owner
  validates :cn, :owner, presence: true
  before_create :acme_request

  belongs_to :owner

  private
  def acme_request
    LocalAcme.instance.request_cert(self)
  end
end
