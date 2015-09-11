require 'active_model/errors'

module ActiveModel
  class Errors
    # Returns a full message for a given attribute.
    #
    #   company.errors.full_message(:name, "is invalid")  # =>
    #     "Name is invalid"
    def full_message(attribute, message)
      puts "#{attribute}: #{message}"
      return message if attribute == :base

      i18n_entry = :"errors.format"
      attr_name = attribute.to_s.gsub('.', '_').humanize
      attr_name = @base.class.human_attribute_name(attribute, :default => attr_name)
      options = { default: "%{attribute} %{message}", attribute: attr_name }

      if message =~ /^\^/
        i18n_entry = :"errors.format.full_message"
        options.merge!(message: message[1..-1], default: "%{message}")
      else
        options.merge!(message: message)
      end

      I18n.t(i18n_entry, options)
    end
  end
end
