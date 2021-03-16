require "test_helper"

class ThesisApplicationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get thesis_applications_create_url
    assert_response :success
  end
end
