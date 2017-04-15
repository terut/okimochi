class ApplicationRepresentation
  include ::JsonWorld::DSL

  schema "http://json-schema.org/draft-04/hyper-schema"

  def as_json(options = {})
    super(options.merge(as_json_options))
  end

  def initialize(model = nil, current_user: nil)
    @current_user = current_user
    @model = model
  end

  private
    def self.inherited_representation(klass)
      klass.property_definitions.each do |d|
        opts = d.raw_options.except(:parent)
        property_name = opts.delete(:property_name)
        property(property_name, opts)
      end

      klass.delegate_property_names.each do |names|
        delegate_properties(*property_names)
      end
    end

    def self.delegate_property_names
      @delegate_properties ||= []
    end

    def self.delegate_properties(*properties)
      delegate_property_names << properties
      delegate(
        *properties,
        to: :model
      )
    end

    def current_user
      @current_user
    end

    def model
      @model
    end

    def as_json_options
      @options ||= {}
    end
end
