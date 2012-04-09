class CartableValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << "must act as cartable" unless value && value.class.acts_as_cartable?
  end
end
