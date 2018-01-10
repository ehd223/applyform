require 'test_helper'

class UviewerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get uviewer_index_url
    assert_response :success
  end

end
