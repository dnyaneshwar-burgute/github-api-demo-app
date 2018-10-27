class ReduceValidator < ActiveModel::EachValidator

  # show only one error message per field
  def validate_each(record, attribute, value)
    # we can skip this in test env so the shoulda
    # matchers and helpers get the expected messages
    unless Rails.env.test?
      return until record.errors.messages.has_key?(attribute)
      record.errors[attribute].slice!(-1) until record.errors[attribute].size <= 1
    end
  end

end
