class BoardRepresentation < ApplicationRepresentation
  inherited_representation Primitive::UserRepresentation

  property(
    :current_article,
    type: Primitive::ArticleRepresentation
  )

  link(
    :list_articles,
    description: "List users with current article",
    path: "/boards.json",
    rel: "instances"
  )

  delegate_properties :current_article
end
