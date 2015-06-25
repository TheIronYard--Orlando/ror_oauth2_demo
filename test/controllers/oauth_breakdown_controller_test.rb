require 'test_helper'

class OauthBreakdownControllerTest < ActionController::TestCase
  test "should get step_1" do
    get :step_1
    assert_response :success
  end

  test "should get step_2" do
    get :step_2
    assert_response :success
  end

  test "should get step_3" do
    get :step_3
    assert_response :success
  end

  test "should get step_4" do
    get :step_4
    assert_response :success
  end

  test "should get step_5" do
    get :step_5
    assert_response :success
  end

end
