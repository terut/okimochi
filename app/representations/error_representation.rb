class ErrorRepresentation
  include ::JsonWorld::DSL

  schema "http://json-schema.org/draft-04/hyper-schema"

  property(
    :message,
    description: "message",
    example: "Not Found",
    type: String
  )

  property(
    :code,
    description: "code",
    exmaple: "not_found",
    type: String
  )

  property(
    :errors,
    description: "errors",
    exmaple: [
      {
        resource: "article",
        field: "title",
        code: "missing_field"
      }
    ],
    items: {
      description: "error of field",
      properties: {
        resource: {
          type: String
        },
        field: {
          type: String
        },
        code: {
          type: String
        }
      }
    },
    type: Array
  )

  property(
    :display_message,
    description: "display message",
    example: "Page not found",
    type: String
  )

  attr_reader :message, :display_message, :code

  def initialize(message, code, model: nil)
    @message = message
    @display_message = message
    @code = code
    @model = model
  end

  def errors
    return [] if model.nil?
    []
  end

  private

    def model
      @model
    end
end
