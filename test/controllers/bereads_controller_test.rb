require "test_helper"

class BereadsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bereads_index_url
    assert_response :success
  end

  test "should get create" do
    get bereads_create_url
    assert_response :success
  end

  test "should get destroy" do
    get bereads_destroy_url
    assert_response :success
  end
end
