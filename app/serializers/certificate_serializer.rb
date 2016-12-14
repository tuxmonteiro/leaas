class CertificateSerializer < ActiveModel::Serializer
  attributes :id, :cn, :last_crt, :csr, :key, :detail, :acme_id, :links
  #has_one :owner

  def links
    [
        {rel: 'self', href: "/owners/#{object.owner.id}/certificates/#{object.id}"},
    ]
  end
end
