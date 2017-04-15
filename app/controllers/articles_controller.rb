class ArticlesController < ApplicationController
  protect_from_forgery except: [:create, :update]

  def create
    article_attrs = article_params.to_h
    current = Time.current
    published_on = current.in_time_zone('UTC').to_date
    article = current_user.articles.build(article_attrs.reverse_merge({
      published_on: published_on,
      edited_at: current
    }))
    article.save
    render json: ArticleRepresentation.new(article, current_user)
  end

  def update
    article_attrs = article_params.to_h
    article = current_user.articles.find(params[:id])
    article.attributes = article_attrs.reverse_merge({
      edited_at: Time.current
    })
    article.save
    render json: ArticleRepresentation.new(article, current_user)
  end

  private
  def article_params
    params.require(:article).permit(:body)
  end
end