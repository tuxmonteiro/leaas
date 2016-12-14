class Owner < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true

  #attr_accessor :name, :email, :pkcs12, :detail, :acme_id
  has_many :certificates
end
