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

  # edited_at is always set timestamp
  test "article's published_on should be set automatically when it's nil" do
    travel_to Time.zone.parse("2017-04-01T00:00:00Z") do
      article = create(:article, published_on: nil, edited_at: nil)
      assert_equal "2017-04-01", article.published_on.to_s
      assert_equal "2017-04-01T00:00:00Z", article.edited_at.iso8601
    end

    article = nil
    travel_to Time.zone.parse("2017-04-01T18:00:00Z") do
      article = create(:article, published_on: "2017-03-30", edited_at: "2017-04-01T20:00:00Z")
      assert_equal "2017-03-30", article.published_on.to_s
      assert_equal "2017-04-01T18:00:00Z", article.edited_at.iso8601
    end
    travel_to Time.zone.parse("2017-04-02T15:00:00Z") do
      article.update_attributes(body: "#{article.body} update!")
      assert_equal "2017-03-30", article.published_on.to_s
      assert_equal "2017-04-02T15:00:00Z", article.edited_at.iso8601
    end
  end

  test "article should be set published_on referred time zone when article has user" do
    travel_to Time.zone.parse("2017-04-01T00:00:00Z") do
      user = create(:user, time_zone: "Pacific Time (US & Canada)")
      article = user.articles.build(body: "Hi")
      article.save
      assert_equal "2017-03-31", article.published_on.to_s
    end
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

  class FindTodayTest < ActiveSupport::TestCase
    attr_reader :article_today

    setup do
      @article_today ||= create(:article, published_on: "2017-04-01")
    end

    teardown do
      travel_back
    end

    test ".find_today should return today's article when it exists" do
      travel_to Time.zone.parse("2017-04-01T18:00:00") do
        assert_equal article_today, Article.find_today
        user = article_today.user
        assert_equal article_today, user.articles.find_today
      end
      travel_to Time.zone.parse("2017-04-02T00:00:00") do
        assert_nil Article.find_today
        assert_equal article_today, Article.find_today(time_zone: "Pacific Time (US & Canada)")
        user = article_today.user
        assert_equal article_today, user.articles.find_today(time_zone: "Pacific Time (US & Canada)")
      end
    end
  end
end
