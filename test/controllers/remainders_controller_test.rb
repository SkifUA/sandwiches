require 'test_helper'

class RemaindersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @remainder = remainders(:one)
  end

  test "should get index" do
    get remainders_url
    assert_response :success
  end

  test "should get new" do
    get new_remainder_url
    assert_response :success
  end

  test "should create remainder" do
    assert_difference('Remainder.count') do
      post remainders_url, params: { remainder: {  } }
    end

    assert_redirected_to remainder_url(Remainder.last)
  end

  test "should show remainder" do
    get remainder_url(@remainder)
    assert_response :success
  end

  test "should get edit" do
    get edit_remainder_url(@remainder)
    assert_response :success
  end

  test "should update remainder" do
    patch remainder_url(@remainder), params: { remainder: {  } }
    assert_redirected_to remainder_url(@remainder)
  end

  test "should destroy remainder" do
    assert_difference('Remainder.count', -1) do
      delete remainder_url(@remainder)
    end

    assert_redirected_to remainders_url
  end
end
