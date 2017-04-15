class BoardsController < ApplicationController
  def index
    articles = Article.includes(:user).order(edited_at: :desc).limit(20)
    render json: articles.map { |a| ArticleRepresentation.new(a) }
  end
end
