class Owner < ApplicationRecord
  #attr_accessor :name, :email, :pkcs12, :detail, :acme_id
  validates :name, :email, presence: true
  has_many :certificates
end
