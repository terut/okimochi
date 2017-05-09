class BoardRepresentation < ApplicationRepresentation
  inherited_representation Primitive::UserRepresentation

  property(
    :current_article,
    type: Primitive::ArticleRepresentation
  )

  link(
    :list_articles,
    description: "List users with current article",
    path: "/boards",
    rel: "instances"
  )

  def current_article
    Primitive::ArticleRepresentation.new(model.current_article)
  end
end
