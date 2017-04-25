class AuthenticatedUserRepresentation < ApplicationRepresentation
  inherited_representation Primitive::UserRepresentation

  property(
    :time_zone,
    description: "time zone",
    example: "Asia/Tokyo",
    type: String
  )

  link(
    :get_authenticated_user,
    description: "Get authenticated user",
    path: "/user",
  )
end
