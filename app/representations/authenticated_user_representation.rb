class AuthenticatedUserRepresentation < ApplicationRepresentation
  inherited_representation Primitive::UserRepresentation

  link(
    :get_authenticated_user,
    description: "Get authenticated user",
    path: "/user",
  )
end
