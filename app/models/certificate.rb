class Certificate < ApplicationRecord
  validates :cn, presence: true
  validates :owner, presence: true

  #attr_accessor :cn, :last_crt, :csr, :key, :detail, :acme_id, :owner
  belongs_to :owner
end
