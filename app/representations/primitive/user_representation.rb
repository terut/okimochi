class Primitive::UserRepresentation < ApplicationRepresentation
  title "User"

  description "Return user"

  property(
    :id,
    description: "id",
    example: 1,
    type: Integer
  )

  property(
    :username,
    example: "kirito",
    pattern: /^\w{5}$/,
    type: String
  )

  property(
    :name,
    example: "Kirito",
    type: String
  )

  property(
    :avatar,
    example: "https://www.gravatar.com/avatar/2fca43655bea294ead4418b60ffbc7a0.jpg?s=200",
    type: String
  )

  property(
    :bio,
    example: "I'm Beater.",
    type: [ NilClass, String ]
  )

  link(
    :get_user,
    description: "Get a single user",
    path: "/users/:id.json",
  )

  delegate_properties(
    :id,
    :username,
    :name,
    :avatar,
    :bio
  )
end
