class String
  def is_binary_data?
    (self.count('^ -~', "^\r\n").fdiv(self.size) > 0.3 || self.index("\x00")) unless empty?
  end
end

# Adds support for using pluck with multiple fields
module ActiveRecord
  class Base
    def self.multipluck(*args)
      connection.select_all(select(args).arel).each do |attrs|
        attrs.each_key do |attr|
          attrs[attr] = type_cast_attribute(attr, attrs)
        end
      end
    end
  end
end

I18n.enforce_available_locales = false

MultiJson.use :yajl
