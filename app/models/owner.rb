require 'local_acme'

class Owner < ApplicationRecord
  #attr_accessor :name, :email, :private_pem, :detail, :acme_id
  validates :name, :email, presence: true
  before_create :acme_register
  has_many :certificates

  private
  def acme_register
    LocalAcme.instance.register_owner(self)
  end
end
