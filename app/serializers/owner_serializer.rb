class OwnerSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :pkcs12, :detail, :acme_id, :links

  def links
    [
        {rel: 'self', href: "/owners/#{object.id}"},
        {rel: 'certificates', href: "/owners/#{object.id}/certificates"}
    ]
  end
end
