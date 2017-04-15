class ArticleRepresentation < ApplicationRepresentation
  inherited_representation Primitive::ArticleRepresentation

  property(
    :user,
    type: Primitive::UserRepresentation,
    optional: true
  )

  link(
    :list_articles,
    description: "List articles",
    path: "/boards.json",
    rel: "instances"
  )

  link(
    :create_article,
    description: "Create article",
    path: "/articles.json",
    method: "POST"
  )

  link(
    :update_article,
    description: "Update article",
    path: "/articles/:id.json",
    method: "PATCH"
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
