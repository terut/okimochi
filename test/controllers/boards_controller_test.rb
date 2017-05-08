require_relative '../test_helper'
class BoardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    create_list(:article, 2)
  end

  test "boards_url should return a correct response" do
    get boards_url, as: :json

    assert_response :success
    res = JSON.parse(response.body)
    assert JSON::Validator.validate(schema, res)
  end

  private

    def schema
      @schema ||= SchemaRepresentation.as_json_schema
    end
end
