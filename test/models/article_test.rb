require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "body should not be blank" do
    article = build(:article, body: "")
    assert article.invalid?
    article.body = " "
    assert article.invalid?
    article.body = nil
    assert article.invalid?
  end

  test "article which written by a user should be one a day" do
    article = create(:article)
    duplicated_article = build(:article, user: article.user)
    assert duplicated_article.invalid?
    assert_raises(ActiveRecord::RecordNotUnique) { duplicated_article.save!(validate: false) }
  end

  class WithMonthTest < ActiveSupport::TestCase
    attr_reader :article_april, :article_march

    setup do
      @article_april ||= create(:article, published_on: "2017-04-01")
      @article_march ||= create(:article, published_on: "2017-03-31")
      travel_to Time.zone.parse("2017-04-01T00:00:00Z")
    end

    teardown do
      travel_back
    end

    test ".with_month should return this month's articles when month is blank" do
      articles = Article.with_month(nil).map { |a| a.id }
      assert_equal [article_april.id], articles

      articles = Article.with_month(nil, time_zone: "Pacific Time (US & Canada)").map { |a| a.id }
      assert_equal [article_march.id], articles
    end

    test ".with_month should return specific month's articles and no affects from time zone when month is givin" do
      articles = Article.with_month("2017-04").map { |a| a.id }
      assert_equal [article_april.id], articles

      articles = Article.with_month("2017-04", time_zone: "Pacific Time (US & Canada)").map { |a| a.id }
      assert_equal [article_april.id], articles

      articles = Article.with_month("2017-03").map { |a| a.id }
      assert_equal [article_march.id], articles
    end
  end
end
