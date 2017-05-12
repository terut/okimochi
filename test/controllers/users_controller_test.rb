require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  attr_reader :user
  setup do
    @user = create(:user)
    sign_in_as(@user)
  end

  test "GET /users/:id should return a correct response" do
    get "/users/#{user.id}", headers: { "Accept" => "application/json" }, as: :json

    assert_response :success
    res = JSON.parse(response.body)
    assert JSON::Validator.validate(schema, res, fragment: "#/properties/users", strict: true)
  end

  test "GET /user should return a correct response" do
    get user_url, headers: { "Accept" => "application/json" }, as: :json

    assert_response :success
    res = JSON.parse(response.body)
    assert JSON::Validator.validate(schema, res, fragment: "#/properties/authenticated_user", strict: true)
  end

  private

    def schema
      @schema ||= SchemaRepresentation.as_json_schema
    end
end
