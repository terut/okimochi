class UserRepresentation < ApplicationRepresentation
  property :id
  property :username
  property :name
  property :avatar
  property :bio
  property :articles

  delegate(
    :id,
    :username,
    :name,
    :avatar,
    :bio,
    to: :model
  )

  attr_reader :articles

  def initialize(user, articles: nil, current_user: nil)
    super(user, current_user: current_user)
    @articles = articles
    as_json_options[:except] = [:articles] if articles.nil?
  end
end
