class ArticleRepresentation < ApplicationRepresentation
  property :id
  property :body
  property :published_on
  property :edited_at
  property :user, type: UserRepresentation

  delegate(
    :id,
    :body,
    :published_on,
    :edited_at,
    to: :model
  )

  def user
    UserRepresentation.new(model.user)
  end
end
