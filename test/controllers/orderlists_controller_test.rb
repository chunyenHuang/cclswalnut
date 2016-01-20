require 'test_helper'

class OrderlistsControllerTest < ActionController::TestCase
  test "should get index_pics" do
    get :index_pics
    assert_response :success
  end

end
