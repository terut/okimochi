# To output JSON Schema
class SchemaRepresentation
  include JsonWorld::DSL

  schema "http://json-schema.org/draft-04/hyper-schema"
  title "Private API endpoint"
  description "Use json schema"

  property :boards, links: true, type: BoardRepresentation
  property :articles, links: true, type: ArticleRepresentation
  property :users, links: true, type: UserRepresentation
  property :authenticated_user, links: true, type: AuthenticatedUserRepresentation
end
