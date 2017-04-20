class ArticleRepresentation < ApplicationRepresentation
  inherited_representation Primitive::ArticleRepresentation

  property(
    :user,
    type: Primitive::UserRepresentation,
    optional: true
  )

  link(
    :create_article,
    description: "Create article",
    path: "/articles",
    method: "POST"
  )

  link(
    :update_article,
    description: "Update article",
    path: "/articles/:id",
    method: "PATCH"
  )

  link(
    :current_article,
    description: "Today's article. Return `204 No Content` if authenticated user haven't write today's article yet.",
    path: "/article"
  )

  attr_reader :user

  def initialize(article, user: nil, current_user: nil)
    super(article, current_user: current_user)
    if user.nil?
      as_json_options[:except] = [:user]
    else
      @user = Primitive::UserRepresentation.new(user)
    end
  end
end
