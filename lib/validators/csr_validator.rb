class CsrValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless is_base64csr?(value)
      record.errors[attribute] << (options[:message] || "is not an base64 csr")
    end
  end

  def is_base64csr?(value)
    true
  end
end