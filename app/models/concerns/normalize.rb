module Normalize
  extend ActiveSupport::Concern

  class_methods do
    def nullified_attributes
      @nullified_attributes ||= []
    end

    def nullify(*attrs)
      attrs.each do |attr_name|
        nullified_attributes << attr_name
      end
    end
  end

  included do
    before_validation :nullify
  end

  def nullify
    self.class.nullified_attributes.each do |attr_name|
      write_attribute(attr_name, nil) if read_attribute(attr_name).blank?
    end
  end
end
