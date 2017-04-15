# To output JSON Schema
class SchemaRepresentation
  include JsonWorld::DSL

  schema "http://json-schema.org/draft-04/hyper-schema"
  title "Private API endpoint"
  description "Use json schema"

  property :articles, links: true, type: ArticleRepresentation
  property :users, links: true, type: UserRepresentation
end
