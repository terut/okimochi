class UserRepresentation < ApplicationRepresentation
  inherited_representation Primitive::UserRepresentation

  property(
    :articles,
    items: {
      type: Primitive::ArticleRepresentation
    },
    type: Array
  )

  link(
    :get_user,
    description: "Get a single user with the user's articles a month",
    path: "/users/:id.json",
    parameters: {
      date: {
        example: "2017-03-15",
        description: "Get user with articles on March, 2017",
        type: Date,
      }
    }
  )

  attr_reader :articles

  def initialize(user, articles: nil, current_user: nil)
    super(user, current_user: current_user)
    if articles.nil?
      as_json_options[:except] = [:articles]
    else
      @articles = articles.map { |a| Primitive::ArticleRepresentation.new(a) }
    end
  end
end
