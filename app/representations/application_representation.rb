class ApplicationRepresentation
  include ::JsonWorld::DSL

  def as_json(options = {})
    super(options.merge(as_json_options))
  end

  def initialize(model = nil, current_user: nil)
    @current_user = current_user
    @model = model
  end

  private

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
