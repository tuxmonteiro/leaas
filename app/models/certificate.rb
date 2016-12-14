class Certificate < ApplicationRecord
  #attr_accessor :cn, :last_crt, :csr, :key, :detail, :acme_id, :owner
  validates :cn, :owner, presence: true
  belongs_to :owner
end
