require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get order_products" do
    get reports_order_products_url
    assert_response :success
  end

  test "should get send_order_products" do
    get reports_send_order_products_url
    assert_response :success
  end

end
