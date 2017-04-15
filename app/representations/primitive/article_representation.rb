class Primitive::ArticleRepresentation < ApplicationRepresentation
  property(
    :id,
    description: "id",
    example: 1,
    type: Integer
  )

  property(
    :body,
    example: "Today, I defeated my opponent.",
    type: String
  )

  property(
    :published_on,
    example: "2017-03-01",
    type: String
  )

  property(
    :edited_at,
    example: "2017-03-01T18:00:00Z",
    type: Time
  )

  delegate_properties(
    :id,
    :body,
    :published_on,
    :edited_at
  )
end
