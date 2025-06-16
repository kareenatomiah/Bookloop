require "test_helper"

class LibrariesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get libraries_create_url
    assert_response :success
  end

  test "should get destroy" do
    get libraries_destroy_url
    assert_response :success
  end
end
