class ArticlesController < ApplicationController
  protect_from_forgery except: [:create, :update]

  def create
    article = current_user.articles.build(article_params)
    article.save
    render json: ArticleRepresentation.new(article, user: current_user)
  end

  def update
    article = current_user.articles.find(params[:id])
    article.update_attributes(article_params)
    render json: ArticleRepresentation.new(article, user: current_user)
  end

  def today
    if article = current_user.articles.find_today(time_zone: preferred_time_zone)
      render json: ArticleRepresentation.new(article, user: current_user)
    else
      head :no_content
    end
  end

  private

    def article_params
      params.require(:article).permit(:body)
    end
end
