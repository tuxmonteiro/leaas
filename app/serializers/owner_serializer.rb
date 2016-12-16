class OwnerSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :private_pem, :detail, :acme_id, :links

  def links
    [
        {rel: 'self', href: "#{ApplicationController.hostname}/owners/#{object.id}"},
        {rel: 'certificates', href: "#{ApplicationController.hostname}/owners/#{object.id}/certificates"}
    ]
  end
end
