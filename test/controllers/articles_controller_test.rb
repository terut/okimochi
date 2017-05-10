require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  attr_reader :article
  setup do
    @article = create(:article)
    sign_in_as(@article.user)
  end

  test "POST /articles should return a correct response" do
    assert_difference('Article.count', 1) do
      post articles_url, params: { article: { body: "abc" } }, headers: { "Accept" => "application/json" }, as: :json
    end

    assert_response :success
    res = JSON.parse(response.body)
    assert JSON::Validator.validate(schema, res, fragment: "#/properties/articles", strict: true)
  end

  test "PATCH /articles/:id should return a correct response" do
    # TODO check path builder
    patch "/articles/#{article.id}", params: { article: { body: "abc" } }, headers: { "Accept" => "application/json" }, as: :json
    assert_response :success
    res = JSON.parse(response.body)
    assert JSON::Validator.validate(schema, res, fragment: "#/properties/articles", strict: true)

    article.reload
    assert_equal "abc", article.body
  end

  test "GET /article should return a correct response" do
    travel_to Time.zone.parse("#{article.published_on}T00:00:00Z") do
      get article_url, headers: { "Accept" => "application/json" }, as: :json

      assert_response :success
      res = JSON.parse(response.body)
      assert JSON::Validator.validate(schema, res, fragment: "#/properties/articles", strict: true)
    end
  end

  private

    def schema
      @schema ||= SchemaRepresentation.as_json_schema
    end
end
