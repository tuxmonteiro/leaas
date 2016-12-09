class CreateCertificates < ActiveRecord::Migration[5.0]
  def change
    create_table :certificates do |t|
      t.text :certificate
      t.text :private_key
      t.text :signing_request
      t.text :detail
      t.string :acme_id

      t.timestamps
    end
  end
end
