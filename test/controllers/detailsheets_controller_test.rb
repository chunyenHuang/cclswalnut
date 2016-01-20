require 'test_helper'

class DetailsheetsControllerTest < ActionController::TestCase
  test "should get weight:string" do
    get :weight:string
    assert_response :success
  end

end
